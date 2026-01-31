# frozen_string_literal: true

module Layout
  # Horizontal divider for sidebar sections
  #
  # @example Between sections
  #   <%= render Layout::SidebarDividerComponent.new %>
  #
  # @param class [String] Additional CSS classes
  class SidebarDividerComponent < ApplicationComponent
    attr_reader :options

    def initialize(**options)
      @options = options
    end

    def call
      tag.hr(class: divider_classes, **options.except(:class))
    end

    private

    def divider_classes
      class_names(
        "my-4 border-t border-olive-950/5 lg:-mx-4 dark:border-white/5",
        options[:class]
      )
    end
  end
end
