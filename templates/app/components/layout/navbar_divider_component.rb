# frozen_string_literal: true

module Layout
  # Vertical divider for navbar sections
  #
  # @example Between sections
  #   <%= render Layout::NavbarDividerComponent.new %>
  #
  # @param class [String] Additional CSS classes
  class NavbarDividerComponent < ApplicationComponent
    attr_reader :options

    def initialize(**options)
      @options = options
    end

    def call
      tag.div("", "aria-hidden": "true", class: divider_classes, **options.except(:class))
    end

    private

    def divider_classes
      class_names(
        "h-6 w-px bg-olive-950/10 dark:bg-white/10",
        options[:class]
      )
    end
  end
end
