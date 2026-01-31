# frozen_string_literal: true

# Renders a pagination navigation
#
# @example Basic pagination
#   <%= render PaginationComponent.new do %>
#     <%= render PaginationPreviousComponent.new(href: "/page/1") %>
#     <%= render PaginationListComponent.new do %>
#       <%= render PaginationPageComponent.new(href: "/page/1") { "1" } %>
#       <%= render PaginationPageComponent.new(href: "/page/2", current: true) { "2" } %>
#       <%= render PaginationPageComponent.new(href: "/page/3") { "3" } %>
#     <% end %>
#     <%= render PaginationNextComponent.new(href: "/page/3") %>
#   <% end %>
#
# @param aria_label [String] Accessible label for navigation
# @param class [String] Additional CSS classes
class PaginationComponent < ApplicationComponent
  attr_reader :aria_label, :options

  def initialize(aria_label: "Page navigation", **options)
    @aria_label = aria_label
    @options = options
  end

  def call
    tag.nav(content, "aria-label": aria_label, class: pagination_classes, **options.except(:class))
  end

  private

  def pagination_classes
    class_names(
      "flex gap-x-2",
      options[:class]
    )
  end
end
