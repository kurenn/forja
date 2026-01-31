# frozen_string_literal: true

# Renders a table header cell
#
# @example Basic header
#   <%= render TableHeaderComponent.new { "Column Name" } %>
#
# @example With alignment
#   <%= render TableHeaderComponent.new(class: "text-right") { "Amount" } %>
#
# @param bleed [Boolean] Whether table uses bleed mode
# @param grid [Boolean] Whether table shows grid lines
# @param class [String] Additional CSS classes
class TableHeaderComponent < ApplicationComponent
  attr_reader :bleed, :grid, :options

  def initialize(bleed: false, grid: false, **options)
    @bleed = bleed
    @grid = grid
    @options = options
  end

  def call
    tag.th(content, class: header_classes, **options.except(:class))
  end

  private

  def header_classes
    class_names(
      "border-b border-b-olive-950/10 px-4 py-2 font-medium",
      "first:pl-[--gutter,--spacing(2)] last:pr-[--gutter,--spacing(2)]",
      "dark:border-b-white/10",
      # Grid lines
      grid && "border-l border-l-olive-950/5 first:border-l-0 dark:border-l-white/5",
      # Bleed adjustments
      !bleed && "sm:first:pl-1 sm:last:pr-1",
      options[:class]
    )
  end
end
