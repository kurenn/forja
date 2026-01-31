# frozen_string_literal: true

# Individual item in a dropdown menu
#
# @example Link item
#   <%= render DropdownItemComponent.new(href: "/edit") { "Edit" } %>
#
# @example Button item
#   <%= render DropdownItemComponent.new(data: { action: "click->form#submit" }) { "Submit" } %>
#
# @example Disabled item
#   <%= render DropdownItemComponent.new(disabled: true) { "Unavailable" } %>
#
# @param href [String] Link URL (renders as link if provided)
# @param disabled [Boolean] Whether the item is disabled
# @param class [String] Additional CSS classes
class DropdownItemComponent < ApplicationComponent
  attr_reader :href, :disabled, :options

  def initialize(href: nil, disabled: false, **options)
    @href = href
    @disabled = disabled
    @options = options
  end

  def call
    if href.present? && !disabled
      link_to(href, class: item_classes, role: "menuitem", data: item_data, **options.except(:class)) do
        content
      end
    else
      tag.button(
        type: "button",
        role: "menuitem",
        disabled: disabled || nil,
        data: item_data,
        class: item_classes,
        **options.except(:class)
      ) do
        content
      end
    end
  end

  private

  def item_data
    data = options[:data] || {}
    data[:action] = "#{data[:action]} dropdown#closeOnSelect".strip if data[:action]
    data[:action] ||= "dropdown#closeOnSelect"
    data
  end

  def item_classes
    class_names(
      # Base styles
      "group cursor-default rounded-lg px-3.5 py-2.5 focus:outline-none sm:px-3 sm:py-1.5",
      # Text styles
      "text-left text-base/6 text-olive-950 sm:text-sm/6 dark:text-white forced-colors:text-[CanvasText]",
      # Focus
      "focus:bg-blue-500 focus:text-white",
      "hover:bg-blue-500 hover:text-white",
      # Disabled state
      classes_if(disabled, "opacity-50 cursor-not-allowed"),
      # Forced colors mode
      "forced-color-adjust-none forced-colors:focus:bg-[Highlight] forced-colors:focus:text-[HighlightText]",
      # Grid layout for icons
      "col-span-full grid grid-cols-[auto_1fr_1.5rem_0.5rem_auto] items-center supports-[grid-template-columns:subgrid]:grid-cols-subgrid",
      # Icons
      "*:data-[slot=icon]:col-start-1 *:data-[slot=icon]:row-start-1 *:data-[slot=icon]:mr-2.5 *:data-[slot=icon]:-ml-0.5 *:data-[slot=icon]:size-5 sm:*:data-[slot=icon]:mr-2 sm:*:data-[slot=icon]:size-4",
      "*:data-[slot=icon]:text-olive-500 focus:*:data-[slot=icon]:text-white hover:*:data-[slot=icon]:text-white dark:*:data-[slot=icon]:text-olive-400",
      # Avatar
      "*:data-[slot=avatar]:mr-2.5 *:data-[slot=avatar]:-ml-1 *:data-[slot=avatar]:size-6 sm:*:data-[slot=avatar]:mr-2 sm:*:data-[slot=avatar]:size-5",
      options[:class]
    )
  end
end
