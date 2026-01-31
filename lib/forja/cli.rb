# frozen_string_literal: true

require "thor"

module Forja
  class CLI < Thor
    def self.exit_on_failure?
      true
    end

    class_option :no_color, type: :boolean, default: false, desc: "Disable colored output"
    class_option :verbose, type: :boolean, default: false, desc: "Show extra debug information"

    desc "new [APP_NAME]", "Create a new Rails application"
    option :path, type: :string, desc: "Directory to create the app in"
    def new(app_name = nil)
      ui = build_ui

      # Check Rails version first
      begin
        Validation.check_rails_version!('8.0.0')
      rescue RailsNotFoundError, RailsVersionError => e
        ui.error(e.message)
        exit(1)
      end

      # Validate app name if provided
      if app_name
        begin
          Validation.validate_app_name!(app_name)
        rescue InvalidAppNameError => e
          ui.error(e.message)
          ui.newline
          app_name = nil # Fall through to wizard
        end
      end

      wizard = Wizard.new(ui: ui, verbose: options[:verbose])
      spec = wizard.run(app_name: app_name, path: options[:path])

      ui.newline
      runner = Runner.new(spec: spec, ui: ui, verbose: options[:verbose])
      runner.run
    rescue Interrupt
      ui.newline
      ui.warn("Cancelled by user")
      exit(1)
    rescue Error => e
      ui.error(e.message)
      exit(1)
    end

    desc "version", "Show Forja version"
    def version
      ui = build_ui
      puts "Forja v#{VERSION}"
    end

    default_task :help_with_banner

    desc "help_with_banner", "Show banner and usage", hide: true
    def help_with_banner
      ui = build_ui
      puts ui.banner
      puts ui.usage
    end

    private

    def build_ui
      UI.new(color: !options[:no_color])
    end
  end
end
