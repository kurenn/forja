# frozen_string_literal: true

module Layout
  # Main sidebar navigation container
  #
  # @example Basic sidebar
  #   <%= render Layout::SidebarComponent.new do %>
  #     <%= render Layout::SidebarHeaderComponent.new do %>
  #       <!-- Logo -->
  #     <% end %>
  #     <%= render Layout::SidebarBodyComponent.new do %>
  #       <!-- Navigation items -->
  #     <% end %>
  #   <% end %>
  #
  # @param class [String] Additional CSS classes
  class SidebarComponent < ApplicationComponent
    attr_reader :options

    def initialize(**options)
      @options = options
    end

    def call
      tag.nav(content, class: sidebar_classes, **options.except(:class))
    end

    private

    def sidebar_classes
      class_names(
        "flex h-full min-h-0 flex-col",
        options[:class]
      )
    end
  end
end
