# frozen_string_literal: true

module Layout
  # Sidebar footer area (typically for user menu/settings)
  #
  # @example With user info
  #   <%= render Layout::SidebarFooterComponent.new do %>
  #     <%= render Layout::SidebarItemComponent.new(href: "/settings") { "Settings" } %>
  #   <% end %>
  #
  # @param class [String] Additional CSS classes
  class SidebarFooterComponent < ApplicationComponent
    attr_reader :options

    def initialize(**options)
      @options = options
    end

    def call
      tag.div(content, class: footer_classes, **options.except(:class))
    end

    private

    def footer_classes
      class_names(
        "flex flex-col border-t border-olive-200 p-4 dark:border-olive-800",
        "[&>[data-slot=section]+[data-slot=section]]:mt-2.5",
        options[:class]
      )
    end
  end
end
