# frozen_string_literal: true

module Layout
  # Text label within sidebar item
  #
  # @example Label
  #   <%= render Layout::SidebarLabelComponent.new { "Dashboard" } %>
  #
  # @param class [String] Additional CSS classes
  class SidebarLabelComponent < ApplicationComponent
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
