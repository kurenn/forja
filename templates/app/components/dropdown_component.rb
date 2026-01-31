# frozen_string_literal: true

# Container for dropdown menu system
#
# @example Basic dropdown
#   <%= render DropdownComponent.new do |dropdown| %>
#     <% dropdown.with_button { "Options" } %>
#     <% dropdown.with_menu do %>
#       <%= render DropdownItemComponent.new(href: "/edit") { "Edit" } %>
#       <%= render DropdownItemComponent.new(href: "/delete") { "Delete" } %>
#     <% end %>
#   <% end %>
#
# @param class [String] Additional CSS classes
class DropdownComponent < ApplicationComponent
  renders_one :button, ->(**options, &block) {
    DropdownButtonComponent.new(**options, &block)
  }
  renders_one :menu, ->(**options, &block) {
    DropdownMenuComponent.new(**options, &block)
  }

  attr_reader :options

  def initialize(**options)
    @options = options
  end

  def call
    tag.div(
      data: { controller: "dropdown" },
      class: class_names("relative inline-block text-left", options[:class])
    ) do
      safe_join([button, menu].compact)
    end
  end
end
