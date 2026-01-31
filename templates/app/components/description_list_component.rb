# frozen_string_literal: true

# Renders a styled description list
#
# @example Basic list
#   <%= render DescriptionListComponent.new do %>
#     <%= render DescriptionTermComponent.new { "Full name" } %>
#     <%= render DescriptionDetailsComponent.new { "John Doe" } %>
#     <%= render DescriptionTermComponent.new { "Email" } %>
#     <%= render DescriptionDetailsComponent.new { "john@example.com" } %>
#   <% end %>
#
# @param class [String] Additional CSS classes
class DescriptionListComponent < ApplicationComponent
  attr_reader :options

  def initialize(**options)
    @options = options
  end

  def call
    tag.dl(content, class: list_classes, **options.except(:class))
  end

  private

  def list_classes
    class_names(
      "grid grid-cols-1 text-base/6",
      "sm:grid-cols-[min(50%,theme(spacing.80))_auto] sm:text-sm/6",
      options[:class]
    )
  end
end
