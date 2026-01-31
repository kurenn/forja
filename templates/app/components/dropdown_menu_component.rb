# frozen_string_literal: true

# Menu panel for dropdown items
#
# @example Basic menu
#   <%= render DropdownMenuComponent.new do %>
#     <%= render DropdownItemComponent.new(href: "/edit") { "Edit" } %>
#   <% end %>
#
# @param anchor [Symbol] Menu position relative to button (:bottom, :top, :left, :right)
# @param class [String] Additional CSS classes
class DropdownMenuComponent < ApplicationComponent
  ANCHORS = {
    bottom: "top-full left-0 mt-2",
    "bottom-end": "top-full right-0 mt-2",
    "bottom-start": "top-full left-0 mt-2",
    top: "bottom-full left-0 mb-2",
    "top-end": "bottom-full right-0 mb-2",
    "top-start": "bottom-full left-0 mb-2"
  }.freeze

  attr_reader :anchor, :options

  def initialize(anchor: :bottom, **options)
    @anchor = anchor
    @options = options
  end

  def call
    tag.div(
      data: { dropdown_target: "menu" },
      role: "menu",
      "aria-orientation": "vertical",
      class: menu_classes,
      **options.except(:class)
    ) do
      content
    end
  end

  private

  def menu_classes
    class_names(
      # Hidden by default
      "hidden",
      # Position
      "absolute z-50",
      anchor_classes,
      # Base styles
      "isolate w-max min-w-48 rounded-xl p-1",
      # Invisible border for forced-colors mode
      "outline outline-transparent focus:outline-none",
      # Handle scrolling
      "overflow-y-auto max-h-96",
      # Popover background
      "bg-white/75 backdrop-blur-xl dark:bg-olive-800/75",
      # Shadows
      "shadow-lg ring-1 ring-olive-950/10 dark:ring-white/10 dark:ring-inset",
      # Grid for subgrid support
      "supports-[grid-template-columns:subgrid]:grid supports-[grid-template-columns:subgrid]:grid-cols-[auto_1fr_1.5rem_0.5rem_auto]",
      # Transitions
      "transition duration-100 ease-out",
      options[:class]
    )
  end

  def anchor_classes
    ANCHORS[anchor.to_s.to_sym] || ANCHORS[:bottom]
  end
end
