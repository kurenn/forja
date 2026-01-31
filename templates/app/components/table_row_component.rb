# frozen_string_literal: true

# Renders a table row, optionally as a clickable link
#
# @example Basic row
#   <%= render TableRowComponent.new do %>
#     <%= render TableCellComponent.new { "Data" } %>
#   <% end %>
#
# @example Clickable row
#   <%= render TableRowComponent.new(href: "/users/1") do %>
#     <%= render TableCellComponent.new { "John Doe" } %>
#   <% end %>
#
# @param href [String] Link URL (makes entire row clickable)
# @param striped [Boolean] Whether table uses striped rows (passed from parent)
# @param class [String] Additional CSS classes
class TableRowComponent < ApplicationComponent
  attr_reader :href, :target, :title, :striped, :options

  def initialize(href: nil, target: nil, title: nil, striped: false, **options)
    @href = href
    @target = target
    @title = title
    @striped = striped
    @options = options
  end

  def call
    tag.tr(
      content,
      data: row_data,
      class: row_classes,
      **options.except(:class)
    )
  end

  private

  def row_data
    data = {}
    data[:href] = href if href.present?
    data[:target] = target if target.present?
    data[:title] = title if title.present?
    data
  end

  def row_classes
    class_names(
      # Focus outline for clickable rows
      href && "has-[[data-row-link]:focus]:outline-2 has-[[data-row-link]:focus]:-outline-offset-2 has-[[data-row-link]:focus]:outline-blue-500 dark:focus-within:bg-white/[0.025]",
      # Striped rows
      striped && "even:bg-olive-950/[0.025] dark:even:bg-white/[0.025]",
      # Hover for clickable rows
      href && striped && "hover:bg-olive-950/5 dark:hover:bg-white/5",
      href && !striped && "hover:bg-olive-950/[0.025] dark:hover:bg-white/[0.025]",
      options[:class]
    )
  end
end
