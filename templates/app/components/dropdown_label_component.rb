# frozen_string_literal: true

# Text label within a dropdown item
#
# @example Basic label
#   <%= render DropdownLabelComponent.new { "Edit item" } %>
#
# @param class [String] Additional CSS classes
class DropdownLabelComponent < ApplicationComponent
  attr_reader :options

  def initialize(**options)
    @options = options
  end

  def call
    tag.span(content, data: { slot: "label" }, class: label_classes, **options.except(:class))
  end

  private

  def label_classes
    class_names(
      "col-start-2 row-start-1",
      options[:class]
    )
  end
end
