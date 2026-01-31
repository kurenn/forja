# frozen_string_literal: true

module Layout
  # Main scrollable content area of the sidebar
  #
  # @example With sections
  #   <%= render Layout::SidebarBodyComponent.new do %>
  #     <%= render Layout::SidebarSectionComponent.new do %>
  #       <!-- Navigation items -->
  #     <% end %>
  #   <% end %>
  #
  # @param class [String] Additional CSS classes
  class SidebarBodyComponent < ApplicationComponent
    attr_reader :options

    def initialize(**options)
      @options = options
    end

    def call
      tag.div(content, class: body_classes, **options.except(:class))
    end

    private

    def body_classes
      class_names(
        "flex flex-1 flex-col overflow-y-auto p-4",
        "[&>[data-slot=section]+[data-slot=section]]:mt-8",
        options[:class]
      )
    end
  end
end
