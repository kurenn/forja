# frozen_string_literal: true

require "tty-spinner"
require "tty-command"
require "fileutils"
require "json"
require "pastel"

module Forja
  # Custom printer that only shows lines with the forge emoji
  class ForgePrinter < TTY::Command::Printers::Quiet
    def initialize(*)
      super
      @pastel = Pastel.new(enabled: true)
    end

    def print_command_start(cmd, *args)
      # Don't print command start
    end

    def print_command_out_data(cmd, *args)
      line = args[0]
      if line
        # Force encoding to UTF-8 to handle emoji comparison
        line_utf8 = line.force_encoding('UTF-8')
        if line_utf8.valid_encoding? && line_utf8.include?("🔨")
          # Strip any existing ANSI codes and re-apply cyan color
          clean_line = line_utf8.gsub(/\e\[([;\d]+)?m/, '').strip
          # Print on a new line without indentation to avoid spinner overlap
          output << "\n" << @pastel.cyan(clean_line)
        end
      end
    end

    def print_command_err_data(cmd, *args)
      # Only show actual errors, not warnings or info
      line = args[0]
      if line && line.match?(/error|Error|ERROR|fatal|Fatal|FATAL/i)
        output << "\n" << line
      end
    end
  end

  class Runner
    attr_reader :spec, :ui, :prompt, :verbose, :cmd

    def initialize(spec:, ui:, verbose: false)
      @spec = spec
      @ui = ui
      @verbose = verbose
      @prompt = TTY::Prompt.new(enable_color: ui.color_enabled)
      @cmd = TTY::Command.new(printer: verbose ? :pretty : ForgePrinter)
    end

    def run
      puts ui.mascot_and_tagline
      check_existing_directory!
      run_rails_new
      ui.newline
      puts ui.summary(spec)
      ui.tip
    end

    private

    def check_existing_directory!
      return unless Validation.directory_exists?(spec.full_path)

      overwrite = prompt.yes?("Directory #{spec.full_path} already exists. Overwrite?", default: false)
      raise DirectoryExistsError, spec.full_path unless overwrite

      FileUtils.rm_rf(spec.full_path) if overwrite
    end

    def forja_root
      File.expand_path("../..", __dir__)
    end

    def template_path
      File.join(forja_root, "template.rb")
    end

    def run_rails_new
      rails_command = build_rails_command

      if verbose
        ui.newline
        puts ui.pastel.dim("Running: #{rails_command}")
        ui.newline
        run_command_with_clean_env(rails_command)
      else
        spinner = TTY::Spinner.new(
          "[:spinner] 🔨 Forging your Rails application…",
          format: :dots,
          success_mark: ui.pastel.green("✓"),
          error_mark: ui.pastel.red("✗")
        )
        
        ui.newline
        spinner.auto_spin
        begin
          run_command_with_clean_env(rails_command)
          spinner.success
        rescue TTY::Command::ExitError => e
          spinner.error
          raise RailsGenerationError, "Rails generation failed: #{e.message}"
        end
      end

      create_forja_json
    end

    def build_rails_command
      [
        "rails", "new", spec.name,
        "-d", "postgresql",
        "--css=tailwind",
        "-m", template_path
      ].join(" ")
    end

    def run_command_with_clean_env(command)
      # Run the command outside of the current bundle context
      # This ensures rails is found from the system gems, not forja's bundle
      Bundler.with_unbundled_env do
        ENV['FORJA_RENDER_DEPLOYMENT'] = spec.render_deployment.to_s
        cmd.run(command, chdir: spec.path)
      end
    end

    def create_forja_json
      File.write(File.join(spec.full_path, "forja.json"), JSON.pretty_generate(spec.to_h))
    end
  end
end
