# frozen_string_literal: true

module Form
  # Renders a form field error message
  #
  # @example Basic error
  #   <%= render Form::ErrorMessageComponent.new { "Email is required" } %>
  #
  # @param class [String] Additional CSS classes
  class ErrorMessageComponent < ApplicationComponent
    attr_reader :options

    def initialize(**options)
      @options = options
    end

    def call
      tag.p(content, data: { slot: "error" }, class: error_classes, **options.except(:class))
    end

    private

    def error_classes
      class_names(
        "text-base/6 text-red-600 sm:text-sm/6 dark:text-red-500",
        options[:class]
      )
    end
  end
end
