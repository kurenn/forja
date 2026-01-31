# frozen_string_literal: true

# Header area at top of dropdown menu
#
# @example With user info
#   <%= render DropdownHeaderComponent.new do %>
#     <p class="font-medium">John Doe</p>
#     <p class="text-sm text-olive-500">john@example.com</p>
#   <% end %>
#
# @param class [String] Additional CSS classes
class DropdownHeaderComponent < ApplicationComponent
  attr_reader :options

  def initialize(**options)
    @options = options
  end

  def call
    tag.div(content, class: header_classes, **options.except(:class))
  end

  private

  def header_classes
    class_names(
      "col-span-5 px-3.5 pt-2.5 pb-1 sm:px-3",
      options[:class]
    )
  end
end
