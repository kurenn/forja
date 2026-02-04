# frozen_string_literal: true

require "pastel"

module Forja
  class UI
    MASCOT = <<~ASCII
                              ⚒
                           ╔═════╗
                          ║ ⚒═══⚒ ║
                         ║  FORJA  ║
                          ║ ═════ ║
                           ╚═════╝
                         ≋≋≋≋≋≋≋≋≋≋≋
                        ≋  🔥🔥🔥  ≋
                       ≋≋≋≋≋≋≋≋≋≋≋≋≋
                      ║███████████████║
                      ║███████████████║
                      ╚═══════════════╝
    ASCII

    TAGLINE = "Forge Rails apps, fast."

    LOADING_PHRASES = [
      "Heating the forge…",
      "Sharpening chisels…",
      "Hammering out a fresh Rails skeleton…",
      "Quenching steel…",
      "Tempering the blade…",
      "Polishing the anvil…",
      "Stoking the flames…"
    ].freeze

    TIPS = [
      "Tip: Use --path to generate somewhere else.",
      "Tip: Run 'forja new my_app' to skip the name prompt.",
      "Tip: Set NO_COLOR=1 to disable colors.",
      "Tip: Use --verbose for extra debug output."
    ].freeze

    attr_reader :pastel, :color_enabled

    def initialize(color: true)
      @color_enabled = color && !ENV.key?("NO_COLOR")
      @pastel = Pastel.new(enabled: @color_enabled)
    end

    def banner
      lines = []
      mascot_lines = MASCOT.lines.map(&:chomp)
      version_line = "#{pastel.bold.cyan('Forja')} #{pastel.dim("v#{VERSION}")}"
      tagline_line = pastel.dim(TAGLINE)
      cwd_line = pastel.dim(abbreviate_path(Dir.pwd))

      max_mascot_width = mascot_lines.map(&:length).max + 2

      content_lines = [version_line, tagline_line, cwd_line]

      mascot_lines.each_with_index do |mascot_line, i|
        padded = mascot_line.ljust(max_mascot_width)
        content = content_lines[i] || ""
        lines << "  #{pastel.yellow(padded)} #{content}"
      end

      lines << ""
      lines << "  #{pastel.dim('›')} Try #{pastel.green('"forja new my_app"')}"
      lines << ""

      lines.join("\n")
    end

    def usage
      [
        pastel.bold("Usage:"),
        "  forja new [APP_NAME] [--path PATH]",
        "",
        pastel.bold("Options:"),
        "  --path PATH    Directory to create the app in (default: current directory)",
        "  --no-color     Disable colored output",
        "  --verbose      Show extra debug information",
        ""
      ].join("\n")
    end

    def random_loading_phrase
      LOADING_PHRASES.sample
    end

    def random_tip
      TIPS.sample
    end

    def success(message)
      puts pastel.green("✓ #{message}")
    end

    def error(message)
      puts pastel.red("✗ #{message}")
    end

    def info(message)
      puts pastel.cyan("ℹ #{message}")
    end

    def warn(message)
      puts pastel.yellow("⚠ #{message}")
    end

    def dim(message)
      puts pastel.dim(message)
    end

    def tip
      puts pastel.dim("  #{random_tip}")
    end

    def newline
      puts
    end

    def mascot_and_tagline
      [
        "",
        pastel.yellow(MASCOT),
        pastel.bold.cyan("Forja"),
        pastel.dim(TAGLINE),
        ""
      ].join("\n")
    end

    def summary(spec)
      [
        "",
        pastel.bold.green("🔨 App forged successfully!"),
        "",
        "  #{pastel.bold('App name:')}  #{spec.name}",
        "  #{pastel.bold('Location:')}  #{spec.full_path}",
        "",
        pastel.bold("  Included:"),
        "    #{pastel.green('✓')} Rails + PostgreSQL",
        "    #{pastel.green('✓')} Tailwind CSS (Oatmeal Olive theme)",
        "    #{pastel.green('✓')} RSpec + FactoryBot + Shoulda Matchers",
        "    #{pastel.green('✓')} Devise authentication (User model)",
        "    #{pastel.green('✓')} Custom auth views",
        "    #{pastel.green('✓')} claude-on-rails gem with swarm agents",
        "    #{pastel.green('✓')} Component library & design system",
        "",
        pastel.bold("  Next steps:"),
        pastel.dim("    cd #{spec.full_path}"),
        pastel.dim("    bin/dev"),
        ""
      ].join("\n")
    end

    private

    def abbreviate_path(path)
      home = ENV["HOME"]
      return path unless home

      path.sub(/\A#{Regexp.escape(home)}/, "~")
    end
  end
end
