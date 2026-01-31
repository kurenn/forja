# frozen_string_literal: true

# Horizontal divider between dropdown sections
#
# @example Between items
#   <%= render DropdownDividerComponent.new %>
#
# @param class [String] Additional CSS classes
class DropdownDividerComponent < ApplicationComponent
  attr_reader :options

  def initialize(**options)
    @options = options
  end

  def call
    tag.hr(role: "separator", class: divider_classes, **options.except(:class))
  end

  private

  def divider_classes
    class_names(
      "col-span-full mx-3.5 my-1 h-px border-0",
      "bg-olive-950/5 sm:mx-3 dark:bg-white/10",
      "forced-colors:bg-[CanvasText]",
      options[:class]
    )
  end
end
