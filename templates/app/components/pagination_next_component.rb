# frozen_string_literal: true

# Renders a next page button in pagination
#
# @example Enabled
#   <%= render PaginationNextComponent.new(href: "/page/3") %>
#
# @example Disabled (last page)
#   <%= render PaginationNextComponent.new %>
#
# @param href [String] Link URL (disabled if nil)
# @param class [String] Additional CSS classes
class PaginationNextComponent < ApplicationComponent
  attr_reader :href, :options

  def initialize(href: nil, **options)
    @href = href
    @options = options
  end

  def call
    tag.span(class: wrapper_classes) do
      if href.present?
        link_to(href, class: button_classes, "aria-label": "Next page") do
          safe_join([content.presence || "Next", arrow_icon])
        end
      else
        tag.button(
          type: "button",
          disabled: true,
          class: button_classes,
          "aria-label": "Next page"
        ) do
          safe_join([content.presence || "Next", arrow_icon])
        end
      end
    end
  end

  private

  def wrapper_classes
    class_names("flex grow basis-0 justify-end", options[:class])
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
        d: "M13.25 8L2.75 8M13.25 8L10.75 10.5M13.25 8L10.75 5.5",
        "stroke-width": "1.5",
        "stroke-linecap": "round",
        "stroke-linejoin": "round"
      )
    end
  end
end
