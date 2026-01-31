# frozen_string_literal: true

# Renders a table data cell
#
# @example Basic cell
#   <%= render TableCellComponent.new { "Data value" } %>
#
# @example With alignment
#   <%= render TableCellComponent.new(class: "text-right") { "$100.00" } %>
#
# @param href [String] Link URL from parent row (for clickable rows)
# @param target [String] Link target from parent row
# @param title [String] Link title/label from parent row
# @param bleed [Boolean] Whether table uses bleed mode
# @param dense [Boolean] Whether table uses dense mode
# @param grid [Boolean] Whether table shows grid lines
# @param striped [Boolean] Whether table uses striped rows
# @param class [String] Additional CSS classes
class TableCellComponent < ApplicationComponent
  attr_reader :href, :target, :title, :bleed, :dense, :grid, :striped, :options

  def initialize(href: nil, target: nil, title: nil, bleed: false, dense: false, grid: false, striped: false, **options)
    @href = href
    @target = target
    @title = title
    @bleed = bleed
    @dense = dense
    @grid = grid
    @striped = striped
    @options = options
  end

  def call
    tag.td(class: cell_classes, **options.except(:class)) do
      safe_join([
        row_link,
        content
      ].compact)
    end
  end

  private

  def cell_classes
    class_names(
      "relative px-4 first:pl-[--gutter,--spacing(2)] last:pr-[--gutter,--spacing(2)]",
      # Border
      !striped && "border-b border-olive-950/5 dark:border-white/5",
      # Grid lines
      grid && "border-l border-l-olive-950/5 first:border-l-0 dark:border-l-white/5",
      # Padding
      dense ? "py-2.5" : "py-4",
      # Bleed adjustments
      !bleed && "sm:first:pl-1 sm:last:pr-1",
      options[:class]
    )
  end

  def row_link
    return unless href.present?

    link_to(
      "",
      href,
      target: target,
      "aria-label": title,
      tabindex: -1,
      data: { row_link: true },
      class: "absolute inset-0 focus:outline-none"
    )
  end
end
