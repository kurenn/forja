# frozen_string_literal: true

# Renders a modal dialog with backdrop and panel
#
# @example Basic usage
#   <%= render ModalComponent.new(id: 'confirm-dialog', title: 'Confirm Action') do %>
#     Are you sure you want to proceed?
#   <% end %>
#
# @example With slots
#   <%= render ModalComponent.new(id: 'user-modal') do |modal| %>
#     <% modal.with_title { 'User Details' } %>
#     <% modal.with_body do %>
#       <p>User information goes here</p>
#     <% end %>
#     <% modal.with_actions do %>
#       <%= button_tag 'Save', type: 'button', data: { action: 'modal#close' } %>
#     <% end %>
#   <% end %>
#
# @param id [String] Unique identifier for the modal
# @param title [String] Optional modal title
# @param size [Symbol] Modal size (:sm, :md, :lg, :xl, :full)
# @param icon [String] Optional icon name for header
# @param icon_variant [Symbol] Icon color variant (:success, :danger, :warning, :info)
class ModalComponent < ApplicationComponent
  renders_one :title
  renders_one :body
  renders_one :actions

  attr_reader :id, :size, :icon, :icon_variant

  SIZES = {
    sm: "sm:max-w-sm",
    md: "sm:max-w-md",
    lg: "sm:max-w-lg",
    xl: "sm:max-w-xl",
    full: "sm:max-w-full"
  }.freeze

  ICON_VARIANTS = {
    success: { bg: "bg-green-100 dark:bg-green-500/10", color: "text-green-600 dark:text-green-400" },
    danger: { bg: "bg-red-100 dark:bg-red-500/10", color: "text-red-600 dark:text-red-400" },
    warning: { bg: "bg-yellow-100 dark:bg-yellow-500/10", color: "text-yellow-600 dark:text-yellow-400" },
    info: { bg: "bg-blue-100 dark:bg-blue-500/10", color: "text-blue-600 dark:text-blue-400" }
  }.freeze

  def initialize(id:, title: nil, size: :lg, icon: nil, icon_variant: :success)
    @id = id
    @title_text = title
    @size = size
    @icon = icon
    @icon_variant = icon_variant
  end

  def title_content
    title? ? title : @title_text
  end

  def panel_size_class
    SIZES[size] || SIZES[:lg]
  end

  def icon_bg_class
    ICON_VARIANTS.dig(icon_variant, :bg) || ICON_VARIANTS.dig(:success, :bg)
  end

  def icon_color_class
    ICON_VARIANTS.dig(icon_variant, :color) || ICON_VARIANTS.dig(:success, :color)
  end

  def icon_svg
    case icon
    when "check"
      '<path d="m4.5 12.75 6 6 9-13.5" stroke-linecap="round" stroke-linejoin="round" />'.html_safe
    when "x"
      '<path d="M6 18 18 6M6 6l12 12" stroke-linecap="round" stroke-linejoin="round" />'.html_safe
    when "exclamation"
      '<path d="M12 9v3.75m-9.303 3.376c-.866 1.5.217 3.374 1.948 3.374h14.71c1.73 0 2.813-1.874 1.948-3.374L13.949 3.378c-.866-1.5-3.032-1.5-3.898 0L2.697 16.126ZM12 15.75h.007v.008H12v-.008Z" stroke-linecap="round" stroke-linejoin="round" />'.html_safe
    when "info"
      '<path d="m11.25 11.25.041-.02a.75.75 0 0 1 1.063.852l-.708 2.836a.75.75 0 0 0 1.063.853l.041-.021M21 12a9 9 0 1 1-18 0 9 9 0 0 1 18 0Zm-9-3.75h.008v.008H12V8.25Z" stroke-linecap="round" stroke-linejoin="round" />'.html_safe
    else
      '<path d="m4.5 12.75 6 6 9-13.5" stroke-linecap="round" stroke-linejoin="round" />'.html_safe
    end
  end
end
