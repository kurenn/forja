# frozen_string_literal: true

module Form
  # Renders a legend for a fieldset
  #
  # @example Basic legend
  #   <%= render Form::LegendComponent.new { "Contact Information" } %>
  #
  # @param class [String] Additional CSS classes
  class LegendComponent < ApplicationComponent
    attr_reader :options

    def initialize(**options)
      @options = options
    end

    def call
      tag.legend(content, data: { slot: "legend" }, class: legend_classes, **options.except(:class))
    end

    private

    def legend_classes
      class_names(
        "text-base/6 font-semibold text-olive-950 sm:text-sm/6 dark:text-white",
        options[:class]
      )
    end
  end
end
