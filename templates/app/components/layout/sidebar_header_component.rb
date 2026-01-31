# frozen_string_literal: true

module Layout
  # Sidebar header area (typically for logo/branding)
  #
  # @example With logo
  #   <%= render Layout::SidebarHeaderComponent.new do %>
  #     <img src="/logo.svg" alt="Logo" />
  #   <% end %>
  #
  # @param class [String] Additional CSS classes
  class SidebarHeaderComponent < ApplicationComponent
    attr_reader :options

    def initialize(**options)
      @options = options
    end

    def call
      tag.div(content, class: header_classes, **options.except(:class))
    end

    private

    def header_classes
      class_names(
        "flex flex-col border-b border-olive-950/5 p-4 dark:border-white/5",
        "[&>[data-slot=section]+[data-slot=section]]:mt-2.5",
        options[:class]
      )
    end
  end
end
