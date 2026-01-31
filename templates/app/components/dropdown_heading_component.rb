# frozen_string_literal: true

# Section heading within dropdown menu
#
# @example Basic heading
#   <%= render DropdownHeadingComponent.new { "Actions" } %>
#
# @param class [String] Additional CSS classes
class DropdownHeadingComponent < ApplicationComponent
  attr_reader :options

  def initialize(**options)
    @options = options
  end

  def call
    tag.div(content, class: heading_classes, **options.except(:class))
  end

  private

  def heading_classes
    class_names(
      "col-span-full grid grid-cols-[1fr_auto] gap-x-12 px-3.5 pt-2 pb-1",
      "text-sm/5 font-medium text-olive-500 sm:px-3 sm:text-xs/5 dark:text-olive-400",
      options[:class]
    )
  end
end
