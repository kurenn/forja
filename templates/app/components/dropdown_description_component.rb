# frozen_string_literal: true

# Description text within a dropdown item
#
# @example With description
#   <%= render DropdownDescriptionComponent.new { "This will permanently remove the item" } %>
#
# @param class [String] Additional CSS classes
class DropdownDescriptionComponent < ApplicationComponent
  attr_reader :options

  def initialize(**options)
    @options = options
  end

  def call
    tag.span(content, data: { slot: "description" }, class: description_classes, **options.except(:class))
  end

  private

  def description_classes
    class_names(
      "col-span-2 col-start-2 row-start-2",
      "text-sm/5 text-olive-500 group-focus:text-white group-hover:text-white sm:text-xs/5 dark:text-olive-400",
      "forced-colors:group-focus:text-[HighlightText]",
      options[:class]
    )
  end
end
