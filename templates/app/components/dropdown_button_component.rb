# frozen_string_literal: true

# Button that triggers the dropdown menu
#
# @example Basic button
#   <%= render DropdownButtonComponent.new { "Options" } %>
#
# @param class [String] Additional CSS classes
class DropdownButtonComponent < ApplicationComponent
  attr_reader :options

  def initialize(**options)
    @options = options
  end

  def call
    tag.button(
      type: "button",
      data: { action: "dropdown#toggle", dropdown_target: "button" },
      "aria-haspopup": "true",
      "aria-expanded": "false",
      class: button_classes,
      **options.except(:class)
    ) do
      content
    end
  end

  private

  def button_classes
    class_names(
      "inline-flex items-center justify-center gap-2 rounded-lg px-3 py-2",
      "text-sm font-medium text-olive-950 dark:text-white",
      "bg-white ring-1 ring-olive-950/10 hover:bg-olive-50",
      "dark:bg-olive-800 dark:ring-white/10 dark:hover:bg-olive-700",
      "focus:outline-none focus-visible:ring-2 focus-visible:ring-olive-900",
      options[:class]
    )
  end
end
