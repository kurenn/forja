# Renders flash messages with different variants
#
# @example Success message
#   <%= render FlashComponent.new(type: :notice, message: "Successfully saved!") %>
#
# @example Error message
#   <%= render FlashComponent.new(type: :alert, message: "Something went wrong") %>
#
# @example Warning message
#   <%= render FlashComponent.new(type: :warning, message: "Please check your input") %>
#
# @param type [Symbol] Flash type (:notice, :alert, :warning, :info)
# @param message [String] The message to display
# @param description [String] Optional detailed description
class FlashComponent < ApplicationComponent
  VARIANTS = {
    notice: {
      icon: "check-circle",
      color: "green",
      title: "Success"
    },
    alert: {
      icon: "x-circle",
      color: "red",
      title: "Error"
    },
    warning: {
      icon: "exclamation-triangle",
      color: "yellow",
      title: "Warning"
    },
    info: {
      icon: "info-circle",
      color: "blue",
      title: "Info"
    }
  }.freeze

  attr_reader :type, :message, :description

  def initialize(type:, message:, description: nil)
    @type = type.to_sym
    @message = message
    @description = description
  end

  def variant
    VARIANTS[@type] || VARIANTS[:info]
  end

  def icon_svg
    case variant[:icon]
    when "check-circle"
      '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" aria-hidden="true" class="size-6 text-green-400"><path d="M9 12.75 11.25 15 15 9.75M21 12a9 9 0 1 1-18 0 9 9 0 0 1 18 0Z" stroke-linecap="round" stroke-linejoin="round" /></svg>'.html_safe
    when "x-circle"
      '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" aria-hidden="true" class="size-6 text-red-400"><path d="m9.75 9.75 4.5 4.5m0-4.5-4.5 4.5M21 12a9 9 0 1 1-18 0 9 9 0 0 1 18 0Z" stroke-linecap="round" stroke-linejoin="round" /></svg>'.html_safe
    when "exclamation-triangle"
      '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" aria-hidden="true" class="size-6 text-yellow-400"><path d="M12 9v3.75m-9.303 3.376c-.866 1.5.217 3.374 1.948 3.374h14.71c1.73 0 2.813-1.874 1.948-3.374L13.949 3.378c-.866-1.5-3.032-1.5-3.898 0L2.697 16.126ZM12 15.75h.007v.008H12v-.008Z" stroke-linecap="round" stroke-linejoin="round" /></svg>'.html_safe
    when "info-circle"
      '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" aria-hidden="true" class="size-6 text-blue-400"><path d="m11.25 11.25.041-.02a.75.75 0 0 1 1.063.852l-.708 2.836a.75.75 0 0 0 1.063.853l.041-.021M21 12a9 9 0 1 1-18 0 9 9 0 0 1 18 0Zm-9-3.75h.008v.008H12V8.25Z" stroke-linecap="round" stroke-linejoin="round" /></svg>'.html_safe
    end
  end
end
