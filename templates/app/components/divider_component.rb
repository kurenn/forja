# frozen_string_literal: true

# Renders a horizontal divider line
#
# @example Basic divider
#   <%= render DividerComponent.new %>
#
# @example Soft (lighter) divider
#   <%= render DividerComponent.new(soft: true) %>
#
# @param soft [Boolean] Use softer/lighter border color. Default: false
# @param class [String] Additional CSS classes
class DividerComponent < ApplicationComponent
  attr_reader :soft, :options

  def initialize(soft: false, **options)
    @soft = soft
    @options = options
  end

  def call
    tag.hr(role: "presentation", class: classes, **options.except(:class))
  end

  private

  def classes
    class_names(
      "w-full border-t",
      border_classes,
      options[:class]
    )
  end

  def border_classes
    if soft
      "border-olive-950/5 dark:border-white/5"
    else
      "border-olive-950/10 dark:border-white/10"
    end
  end
end
