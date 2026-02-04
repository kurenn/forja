# frozen_string_literal: true

require "tty-prompt"

module Forja
  class Wizard
    attr_reader :ui, :prompt, :verbose

    def initialize(ui:, verbose: false)
      @ui = ui
      @prompt = TTY::Prompt.new(enable_color: ui.color_enabled)
      @verbose = verbose
    end

    def run(app_name: nil, path: nil)
      name = app_name || ask_app_name
      target_path = path || ask_path
      active_storage = ask_active_storage

      Spec.new(name: name, path: target_path, active_storage: active_storage)
    end

    private

    def ask_app_name
      prompt.ask("What is your app name?") do |q|
        q.required true
        q.validate(Validation::APP_NAME_PATTERN, "Must start with a letter and contain only lowercase letters, numbers, and underscores")
        q.modify :down, :strip
      end
    end

    def ask_path
      default_path = Dir.pwd
      prompt.ask("Where should we create it?", default: default_path) do |q|
        q.required true
        q.modify :strip
      end
    end

    def ask_active_storage
      prompt.yes?("Do you want to install Active Storage for file uploads?", default: false)
    end
  end
end
