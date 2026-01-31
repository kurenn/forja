# frozen_string_literal: true

# Renders a modal dialog following Catalyst patterns
#
# @example Basic dialog
#   <%= render DialogComponent.new(id: "confirm", open: false) do |dialog| %>
#     <% dialog.with_title { "Confirm action" } %>
#     <% dialog.with_description { "Are you sure you want to proceed?" } %>
#     <% dialog.with_actions do %>
#       <%= render ButtonComponent.new(variant: :outline, data: { action: "dialog#close" }) { "Cancel" } %>
#       <%= render ButtonComponent.new { "Confirm" } %>
#     <% end %>
#   <% end %>
#
# @param id [String] Unique identifier for the dialog
# @param open [Boolean] Whether the dialog starts open
# @param size [Symbol] Dialog max-width size
# @param class [String] Additional CSS classes
class DialogComponent < ApplicationComponent
  renders_one :title
  renders_one :description
  renders_one :body
  renders_one :actions

  SIZES = {
    xs: "sm:max-w-xs",
    sm: "sm:max-w-sm",
    md: "sm:max-w-md",
    lg: "sm:max-w-lg",
    xl: "sm:max-w-xl",
    "2xl": "sm:max-w-2xl",
    "3xl": "sm:max-w-3xl",
    "4xl": "sm:max-w-4xl",
    "5xl": "sm:max-w-5xl"
  }.freeze

  attr_reader :id, :open, :size, :options

  def initialize(id:, open: false, size: :lg, **options)
    @id = id
    @open = open
    @size = size
    @options = options
  end

  def call
    tag.div(
      data: { controller: "dialog", dialog_id_value: id },
      class: class_names("contents", options[:class])
    ) do
      safe_join([
        backdrop,
        dialog_container
      ])
    end
  end

  private

  def backdrop
    tag.div(
      "",
      data: { dialog_target: "backdrop", action: "click->dialog#close" },
      class: backdrop_classes
    )
  end

  def backdrop_classes
    class_names(
      "fixed inset-0 z-50 flex w-screen justify-center overflow-y-auto",
      "bg-olive-950/25 px-2 py-2 transition duration-100 dark:bg-olive-950/50",
      "sm:px-6 sm:py-8 lg:px-8 lg:py-16",
      open ? "" : "hidden opacity-0"
    )
  end

  def dialog_container
    tag.div(
      data: { dialog_target: "container" },
      class: container_classes
    ) do
      tag.div(class: "grid min-h-full grid-rows-[1fr_auto] justify-items-center sm:grid-rows-[1fr_auto_3fr] sm:p-4") do
        dialog_panel
      end
    end
  end

  def container_classes
    class_names(
      "fixed inset-0 z-50 w-screen overflow-y-auto pt-6 sm:pt-0",
      open ? "" : "hidden"
    )
  end

  def dialog_panel
    tag.div(
      role: "dialog",
      "aria-modal": "true",
      "aria-labelledby": "#{id}-title",
      data: { dialog_target: "panel" },
      class: panel_classes
    ) do
      panel_content
    end
  end

  def panel_classes
    class_names(
      "row-start-2 w-full min-w-0 rounded-t-3xl p-8 shadow-lg sm:mb-auto sm:rounded-2xl",
      "bg-white ring-1 ring-olive-950/10 dark:bg-olive-900 dark:ring-white/10",
      "transition duration-100 will-change-transform",
      variant_classes(SIZES, size, :lg)
    )
  end

  def panel_content
    safe_join([
      title_element,
      description_element,
      body_element,
      actions_element
    ].compact)
  end

  def title_element
    return unless title?

    tag.h2(
      title,
      id: "#{id}-title",
      class: "text-lg/6 font-semibold text-balance text-olive-950 sm:text-base/6 dark:text-white"
    )
  end

  def description_element
    return unless description?

    tag.p(
      description,
      class: "mt-2 text-pretty text-base/6 text-olive-500 sm:text-sm/6 dark:text-olive-400"
    )
  end

  def body_element
    return unless body?

    tag.div(body, class: "mt-6")
  end

  def actions_element
    return unless actions?

    tag.div(
      actions,
      class: "mt-8 flex flex-col-reverse items-center justify-end gap-3 *:w-full sm:flex-row sm:*:w-auto"
    )
  end
end
