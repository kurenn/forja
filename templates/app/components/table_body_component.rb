# frozen_string_literal: true

# Renders a table body section
#
# @example Basic body
#   <%= render TableBodyComponent.new do %>
#     <%= render TableRowComponent.new do %>
#       <%= render TableCellComponent.new { "Data" } %>
#     <% end %>
#   <% end %>
#
# @param class [String] Additional CSS classes
class TableBodyComponent < ApplicationComponent
  attr_reader :options

  def initialize(**options)
    @options = options
  end

  def call
    tag.tbody(content, class: options[:class], **options.except(:class))
  end
end
