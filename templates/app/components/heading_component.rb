# frozen_string_literal: true

# Renders semantic headings (h1-h6) with consistent styling
#
# @example Basic heading
#   <%= render HeadingComponent.new { "Page Title" } %>
#
# @example H2 heading
#   <%= render HeadingComponent.new(level: 2) { "Section Title" } %>
#
# @example Subheading style
#   <%= render HeadingComponent.new(level: 2, subheading: true) { "Smaller heading" } %>
#
# @param level [Integer] Heading level 1-6. Default: 1
# @param subheading [Boolean] Use smaller subheading style. Default: false
# @param class [String] Additional CSS classes
class HeadingComponent < ApplicationComponent
  attr_reader :level, :subheading, :options

  def initialize(level: 1, subheading: false, **options)
    @level = level.clamp(1, 6)
    @subheading = subheading
    @options = options
  end

  def call
    content_tag(tag, content, class: classes, **options.except(:class))
  end

  private

  def tag
    :"h#{level}"
  end

  def classes
    class_names(
      base_classes,
      options[:class]
    )
  end

  def base_classes
    if subheading
      "text-base/7 font-semibold text-olive-950 sm:text-sm/6 dark:text-white"
    else
      "text-2xl/8 font-semibold text-olive-950 sm:text-xl/8 dark:text-white"
    end
  end
end
