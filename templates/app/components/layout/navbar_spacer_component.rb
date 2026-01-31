# frozen_string_literal: true

module Layout
  # Flexible spacer to push content apart in navbar
  #
  # @example Push items to opposite sides
  #   <%= render Layout::NavbarSpacerComponent.new %>
  #
  # @param class [String] Additional CSS classes
  class NavbarSpacerComponent < ApplicationComponent
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
        "-ml-4 flex-1",
        options[:class]
      )
    end
  end
end
