# frozen_string_literal: true

# Renders a table header section
#
# @example Basic head
#   <%= render TableHeadComponent.new do %>
#     <%= render TableRowComponent.new do %>
#       <%= render TableHeaderComponent.new { "Column" } %>
#     <% end %>
#   <% end %>
#
# @param class [String] Additional CSS classes
class TableHeadComponent < ApplicationComponent
  attr_reader :options

  def initialize(**options)
    @options = options
  end

  def call
    tag.thead(content, class: head_classes, **options.except(:class))
  end

  private

  def head_classes
    class_names(
      "text-olive-500 dark:text-olive-400",
      options[:class]
    )
  end
end
