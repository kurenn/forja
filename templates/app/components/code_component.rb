# frozen_string_literal: true

# Renders inline code with styling
#
# @example Basic usage
#   <%= render CodeComponent.new { "const x = 1" } %>
#
# @param class [String] Additional CSS classes
class CodeComponent < ApplicationComponent
  attr_reader :options

  def initialize(**options)
    @options = options
  end

  def call
    content_tag(:code, content, class: classes, **options.except(:class))
  end

  private

  def classes
    class_names(
      "rounded-sm border border-olive-950/10 bg-olive-950/[0.025] px-0.5",
      "text-sm font-medium text-olive-950 sm:text-[0.8125rem]",
      "dark:border-white/20 dark:bg-white/5 dark:text-white",
      options[:class]
    )
  end
end
