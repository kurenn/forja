# frozen_string_literal: true

module Layout
  # Flexible spacer to push content to bottom
  #
  # @example Push footer to bottom
  #   <%= render Layout::SidebarSpacerComponent.new %>
  #
  # @param class [String] Additional CSS classes
  class SidebarSpacerComponent < ApplicationComponent
    attr_reader :options

    def initialize(**options)
      @options = options
    end

    def call
      tag.div("", "aria-hidden": "true", class: spacer_classes, **options.except(:class))
    end

    private

    def spacer_classes
      class_names(
        "mt-8 flex-1",
        options[:class]
      )
    end
  end
end
