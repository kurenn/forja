# frozen_string_literal: true

# Renders a description details (value) in a description list
#
# @example Basic details
#   <%= render DescriptionDetailsComponent.new { "john@example.com" } %>
#
# @param class [String] Additional CSS classes
class DescriptionDetailsComponent < ApplicationComponent
  attr_reader :options

  def initialize(**options)
    @options = options
  end

  def call
    tag.dd(content, class: details_classes, **options.except(:class))
  end

  private

  def details_classes
    class_names(
      "pt-1 pb-3 text-olive-950",
      "sm:border-t sm:border-olive-950/5 sm:py-3 sm:[&:nth-child(2)]:border-none",
      "dark:text-white dark:sm:border-white/5",
      options[:class]
    )
  end
end
