# frozen_string_literal: true

module Layout
  # Text label within navbar item
  #
  # @example Label
  #   <%= render Layout::NavbarLabelComponent.new { "Dashboard" } %>
  #
  # @param class [String] Additional CSS classes
  class NavbarLabelComponent < ApplicationComponent
    attr_reader :options

    def initialize(**options)
      @options = options
    end

    def call
      tag.span(content, class: label_classes, **options.except(:class))
    end

    private

    def label_classes
      class_names(
        "truncate",
        options[:class]
      )
    end
  end
end
