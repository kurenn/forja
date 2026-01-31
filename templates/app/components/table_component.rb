# frozen_string_literal: true

# Renders a styled data table
#
# @example Basic table
#   <%= render TableComponent.new do %>
#     <%= render TableHeadComponent.new do %>
#       <%= render TableRowComponent.new do %>
#         <%= render TableHeaderComponent.new { "Name" } %>
#         <%= render TableHeaderComponent.new { "Email" } %>
#       <% end %>
#     <% end %>
#     <%= render TableBodyComponent.new do %>
#       <%= render TableRowComponent.new do %>
#         <%= render TableCellComponent.new { "John" } %>
#         <%= render TableCellComponent.new { "john@example.com" } %>
#       <% end %>
#     <% end %>
#   <% end %>
#
# @example With options
#   <%= render TableComponent.new(dense: true, striped: true, grid: true) do %>
#     ...
#   <% end %>
#
# @param bleed [Boolean] Allow table to bleed to edges
# @param dense [Boolean] Use compact row padding
# @param grid [Boolean] Show vertical grid lines
# @param striped [Boolean] Alternate row backgrounds
# @param class [String] Additional CSS classes
class TableComponent < ApplicationComponent
  attr_reader :bleed, :dense, :grid, :striped, :options

  def initialize(bleed: false, dense: false, grid: false, striped: false, **options)
    @bleed = bleed
    @dense = dense
    @grid = grid
    @striped = striped
    @options = options
  end

  def call
    tag.div(class: "flow-root") do
      tag.div(class: wrapper_classes) do
        tag.div(class: inner_classes) do
          tag.table(
            content,
            data: table_data,
            class: table_classes,
            **options.except(:class)
          )
        end
      end
    end
  end

  private

  def wrapper_classes
    class_names(
      "-mx-[--gutter] overflow-x-auto whitespace-nowrap",
      options[:class]
    )
  end

  def inner_classes
    class_names(
      "inline-block min-w-full align-middle",
      bleed ? "" : "sm:px-[--gutter]"
    )
  end

  def table_classes
    "min-w-full text-left text-sm/6 text-olive-950 dark:text-white"
  end

  def table_data
    {
      bleed: bleed.to_s,
      dense: dense.to_s,
      grid: grid.to_s,
      striped: striped.to_s
    }
  end
end
