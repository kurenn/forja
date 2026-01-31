# frozen_string_literal: true

module Layout
  # Groups related navbar items
  #
  # @example Section with items
  #   <%= render Layout::NavbarSectionComponent.new do %>
  #     <%= render Layout::NavbarItemComponent.new(href: "/") { "Home" } %>
  #     <%= render Layout::NavbarItemComponent.new(href: "/about") { "About" } %>
  #   <% end %>
  #
  # @param class [String] Additional CSS classes
  class NavbarSectionComponent < ApplicationComponent
    attr_reader :options

    def initialize(**options)
      @options = options
    end

    def call
      tag.div(content, class: section_classes, **options.except(:class))
    end

    private

    def section_classes
      class_names(
        "flex items-center gap-3",
        options[:class]
      )
    end
  end
end
