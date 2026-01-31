# frozen_string_literal: true

# Renders the list of page numbers in pagination
#
# @example Basic list
#   <%= render PaginationListComponent.new do %>
#     <%= render PaginationPageComponent.new(href: "/page/1") { "1" } %>
#     <%= render PaginationPageComponent.new(href: "/page/2") { "2" } %>
#   <% end %>
#
# @param class [String] Additional CSS classes
class PaginationListComponent < ApplicationComponent
  attr_reader :options

  def initialize(**options)
    @options = options
  end

  def call
    tag.span(content, class: list_classes, **options.except(:class))
  end

  private

  def list_classes
    class_names(
      "hidden items-baseline gap-x-2 sm:flex",
      options[:class]
    )
  end
end
