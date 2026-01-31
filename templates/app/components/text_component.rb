# frozen_string_literal: true

# Renders styled text paragraphs with olive color scheme
#
# @example Basic text
#   <%= render TextComponent.new { "This is some text content." } %>
#
# @example With custom tag
#   <%= render TextComponent.new(as: :span) { "Inline text" } %>
#
# @param as [Symbol] HTML tag to use (:p, :span, :div). Default: :p
# @param class [String] Additional CSS classes
class TextComponent < ApplicationComponent
  attr_reader :tag, :options

  def initialize(as: :p, **options)
    @tag = as
    @options = options
  end

  def call
    content_tag(tag, content, class: classes, data: { slot: "text" }, **options.except(:class))
  end

  private

  def classes
    class_names(
      "text-base/6 text-olive-500 sm:text-sm/6 dark:text-olive-400",
      options[:class]
    )
  end
end
