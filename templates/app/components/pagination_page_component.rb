# frozen_string_literal: true

# Renders a page number button in pagination
#
# @example Regular page
#   <%= render PaginationPageComponent.new(href: "/page/2") { "2" } %>
#
# @example Current page
#   <%= render PaginationPageComponent.new(href: "/page/2", current: true) { "2" } %>
#
# @param href [String] Link URL
# @param current [Boolean] Whether this is the current page
# @param class [String] Additional CSS classes
class PaginationPageComponent < ApplicationComponent
  attr_reader :href, :current, :options

  def initialize(href:, current: false, **options)
    @href = href
    @current = current
    @options = options
  end

  def call
    link_to(
      href,
      class: page_classes,
      "aria-label": "Page #{content}",
      "aria-current": current ? "page" : nil,
      **options.except(:class)
    ) do
      tag.span(content, class: "-mx-0.5")
    end
  end

  private

  def page_classes
    class_names(
      "relative inline-flex items-center justify-center rounded-lg px-3 py-2",
      "text-sm font-medium text-olive-950 dark:text-white",
      "min-w-9 before:absolute before:-inset-px before:rounded-lg",
      "hover:bg-olive-950/5 dark:hover:bg-white/5",
      "focus:outline-none focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-blue-500",
      current && "before:bg-olive-950/5 dark:before:bg-white/10",
      options[:class]
    )
  end
end
