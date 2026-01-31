# frozen_string_literal: true

module Layout
  # Horizontal navigation bar
  #
  # @example Basic navbar
  #   <%= render Layout::NavbarComponent.new do %>
  #     <%= render Layout::NavbarSectionComponent.new do %>
  #       <%= render Layout::NavbarItemComponent.new(href: "/") { "Home" } %>
  #     <% end %>
  #   <% end %>
  #
  # @param class [String] Additional CSS classes
  class NavbarComponent < ApplicationComponent
    attr_reader :options

    def initialize(**options)
      @options = options
    end

    def call
      tag.nav(content, class: navbar_classes, **options.except(:class))
    end

    private

    def navbar_classes
      class_names(
        "flex flex-1 items-center gap-4 py-2.5",
        options[:class]
      )
    end
  end
end
