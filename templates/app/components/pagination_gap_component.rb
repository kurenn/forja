# frozen_string_literal: true

# Renders an ellipsis gap in pagination
#
# @example Basic gap
#   <%= render PaginationGapComponent.new %>
#
# @example Custom content
#   <%= render PaginationGapComponent.new { "..." } %>
#
# @param class [String] Additional CSS classes
class PaginationGapComponent < ApplicationComponent
  attr_reader :options

  def initialize(**options)
    @options = options
  end

  def call
    tag.span(
      content.presence || "&hellip;".html_safe,
      "aria-hidden": "true",
      class: gap_classes,
      **options.except(:class)
    )
  end

  private

  def gap_classes
    class_names(
      "w-9 text-center text-sm/6 font-semibold text-olive-950 select-none dark:text-white",
      options[:class]
    )
  end
end
