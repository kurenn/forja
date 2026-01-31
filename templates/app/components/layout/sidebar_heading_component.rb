# frozen_string_literal: true

module Layout
  # Section heading within sidebar
  #
  # @example Section heading
  #   <%= render Layout::SidebarHeadingComponent.new { "Settings" } %>
  #
  # @param class [String] Additional CSS classes
  class SidebarHeadingComponent < ApplicationComponent
    attr_reader :options

    def initialize(**options)
      @options = options
    end

    def call
      tag.h3(content, class: heading_classes, **options.except(:class))
    end

    private

    def heading_classes
      class_names(
        "mb-1 px-2 text-xs/6 font-medium text-olive-500 dark:text-olive-400",
        options[:class]
      )
    end
  end
end
