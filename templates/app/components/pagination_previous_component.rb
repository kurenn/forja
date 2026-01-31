# frozen_string_literal: true

# Renders a previous page button in pagination
#
# @example Enabled
#   <%= render PaginationPreviousComponent.new(href: "/page/1") %>
#
# @example Disabled (first page)
#   <%= render PaginationPreviousComponent.new %>
#
# @param href [String] Link URL (disabled if nil)
# @param class [String] Additional CSS classes
class PaginationPreviousComponent < ApplicationComponent
  attr_reader :href, :options

  def initialize(href: nil, **options)
    @href = href
    @options = options
  end

  def call
    tag.span(class: wrapper_classes) do
      if href.present?
        link_to(href, class: button_classes, "aria-label": "Previous page") do
          safe_join([arrow_icon, content.presence || "Previous"])
        end
      else
        tag.button(
          type: "button",
          disabled: true,
          class: button_classes,
          "aria-label": "Previous page"
        ) do
          safe_join([arrow_icon, content.presence || "Previous"])
        end
      end
    end
  end

  private

  def wrapper_classes
    class_names("grow basis-0", options[:class])
  end

  def button_classes
    class_names(
      "inline-flex items-center justify-center gap-2 rounded-lg px-3 py-2",
      "text-sm font-medium text-olive-950 dark:text-white",
      "border border-transparent hover:bg-olive-950/5 dark:hover:bg-white/5",
      "focus:outline-none focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-blue-500",
      "disabled:opacity-50 disabled:cursor-not-allowed disabled:hover:bg-transparent"
    )
  end

  def arrow_icon
    tag.svg(
      viewBox: "0 0 16 16",
      fill: "none",
      "aria-hidden": "true",
      data: { slot: "icon" },
      class: "size-4 stroke-current"
    ) do
      tag.path(
        d: "M2.75 8H13.25M2.75 8L5.25 5.5M2.75 8L5.25 10.5",
        "stroke-width": "1.5",
        "stroke-linecap": "round",
        "stroke-linejoin": "round"
      )
    end
  end
end
