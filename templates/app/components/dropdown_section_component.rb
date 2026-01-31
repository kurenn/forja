# frozen_string_literal: true

# Groups related dropdown items
#
# @example Section with heading
#   <%= render DropdownSectionComponent.new do %>
#     <%= render DropdownHeadingComponent.new { "Actions" } %>
#     <%= render DropdownItemComponent.new(href: "/edit") { "Edit" } %>
#   <% end %>
#
# @param class [String] Additional CSS classes
class DropdownSectionComponent < ApplicationComponent
  attr_reader :options

  def initialize(**options)
    @options = options
  end

  def call
    tag.div(content, role: "group", class: section_classes, **options.except(:class))
  end

  private

  def section_classes
    class_names(
      "col-span-full supports-[grid-template-columns:subgrid]:grid supports-[grid-template-columns:subgrid]:grid-cols-[auto_1fr_1.5rem_0.5rem_auto]",
      options[:class]
    )
  end
end
