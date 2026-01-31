# frozen_string_literal: true

module Layout
  # Groups related sidebar items
  #
  # @example Section with items
  #   <%= render Layout::SidebarSectionComponent.new do %>
  #     <%= render Layout::SidebarItemComponent.new(href: "/dashboard") { "Dashboard" } %>
  #     <%= render Layout::SidebarItemComponent.new(href: "/settings") { "Settings" } %>
  #   <% end %>
  #
  # @param class [String] Additional CSS classes
  class SidebarSectionComponent < ApplicationComponent
    attr_reader :options

    def initialize(**options)
      @options = options
    end

    def call
      tag.div(content, data: { slot: "section" }, class: section_classes, **options.except(:class))
    end

    private

    def section_classes
      class_names(
        "flex flex-col gap-0.5",
        options[:class]
      )
    end
  end
end
