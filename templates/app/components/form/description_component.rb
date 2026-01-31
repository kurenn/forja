# frozen_string_literal: true

module Form
  # Renders a form field description/help text
  #
  # @example Basic description
  #   <%= render Form::DescriptionComponent.new { "Enter your email address" } %>
  #
  # @param class [String] Additional CSS classes
  class DescriptionComponent < ApplicationComponent
    attr_reader :options

    def initialize(**options)
      @options = options
    end

    def call
      tag.p(content, data: { slot: "description" }, class: description_classes, **options.except(:class))
    end

    private

    def description_classes
      class_names(
        "text-base/6 text-olive-500 sm:text-sm/6 dark:text-olive-400",
        options[:class]
      )
    end
  end
end
