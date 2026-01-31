# frozen_string_literal: true

# Renders emphasized text with medium font weight
#
# @example Basic usage
#   <%= render StrongComponent.new { "Important text" } %>
#
# @param class [String] Additional CSS classes
class StrongComponent < ApplicationComponent
  attr_reader :options

  def initialize(**options)
    @options = options
  end

  def call
    content_tag(:strong, content, class: classes, **options.except(:class))
  end

  private

  def classes
    class_names(
      "font-medium text-olive-950 dark:text-white",
      options[:class]
    )
  end
end
