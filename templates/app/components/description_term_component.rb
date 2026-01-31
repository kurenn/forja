# frozen_string_literal: true

# Renders a description term (label) in a description list
#
# @example Basic term
#   <%= render DescriptionTermComponent.new { "Email address" } %>
#
# @param class [String] Additional CSS classes
class DescriptionTermComponent < ApplicationComponent
  attr_reader :options

  def initialize(**options)
    @options = options
  end

  def call
    tag.dt(content, class: term_classes, **options.except(:class))
  end

  private

  def term_classes
    class_names(
      "col-start-1 border-t border-olive-950/5 pt-3 text-olive-500",
      "first:border-none",
      "sm:border-t sm:border-olive-950/5 sm:py-3",
      "dark:border-white/5 dark:text-olive-400 sm:dark:border-white/5",
      options[:class]
    )
  end
end
