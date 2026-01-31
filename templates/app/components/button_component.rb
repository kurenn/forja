# frozen_string_literal: true

# Renders a styled button with multiple variants and colors
#
# @example Primary button
#   <%= render ButtonComponent.new { "Click me" } %>
#
# @example Outline button
#   <%= render ButtonComponent.new(variant: :outline) { "Cancel" } %>
#
# @example Plain button
#   <%= render ButtonComponent.new(variant: :plain) { "Learn more" } %>
#
# @example Colored button
#   <%= render ButtonComponent.new(color: :red) { "Delete" } %>
#
# @example Link button
#   <%= render ButtonComponent.new(href: "/dashboard") { "Go to Dashboard" } %>
#
# @example Disabled button
#   <%= render ButtonComponent.new(disabled: true) { "Unavailable" } %>
#
# @param variant [Symbol] Button style (:solid, :outline, :plain). Default: :solid
# @param color [Symbol] Button color (see SOLID_COLORS). Default: :olive
# @param href [String] If provided, renders as a link instead of button
# @param type [String] Button type (button, submit, reset). Default: "button"
# @param disabled [Boolean] Disable the button. Default: false
# @param class [String] Additional CSS classes
class ButtonComponent < ApplicationComponent
  VARIANTS = %i[solid outline plain].freeze

  # Solid button colors (replacing zinc with olive)
  SOLID_COLORS = {
    olive: "text-white bg-olive-900 hover:bg-olive-800 dark:bg-olive-600 dark:hover:bg-olive-500",
    light: "text-olive-950 bg-white hover:bg-olive-50 border-olive-950/10 dark:text-white dark:bg-olive-800 dark:hover:bg-olive-700",
    white: "text-olive-950 bg-white hover:bg-olive-50 border-olive-950/10",
    red: "text-white bg-red-600 hover:bg-red-500",
    orange: "text-white bg-orange-500 hover:bg-orange-400",
    amber: "text-amber-950 bg-amber-400 hover:bg-amber-300",
    yellow: "text-yellow-950 bg-yellow-300 hover:bg-yellow-200",
    lime: "text-lime-950 bg-lime-300 hover:bg-lime-200",
    green: "text-white bg-green-600 hover:bg-green-500",
    emerald: "text-white bg-emerald-600 hover:bg-emerald-500",
    teal: "text-white bg-teal-600 hover:bg-teal-500",
    cyan: "text-cyan-950 bg-cyan-300 hover:bg-cyan-200",
    sky: "text-white bg-sky-500 hover:bg-sky-400",
    blue: "text-white bg-blue-600 hover:bg-blue-500",
    indigo: "text-white bg-indigo-500 hover:bg-indigo-400",
    violet: "text-white bg-violet-500 hover:bg-violet-400",
    purple: "text-white bg-purple-500 hover:bg-purple-400",
    fuchsia: "text-white bg-fuchsia-500 hover:bg-fuchsia-400",
    pink: "text-white bg-pink-500 hover:bg-pink-400",
    rose: "text-white bg-rose-500 hover:bg-rose-400"
  }.freeze

  OUTLINE_CLASSES = "border-olive-950/10 text-olive-950 hover:bg-olive-950/[0.025] dark:border-white/15 dark:text-white dark:hover:bg-white/5"
  PLAIN_CLASSES = "border-transparent text-olive-950 hover:bg-olive-950/5 dark:text-white dark:hover:bg-white/10"

  attr_reader :variant, :color, :href, :type, :disabled, :options

  def initialize(variant: :solid, color: :olive, href: nil, type: "button", disabled: false, **options)
    @variant = variant
    @color = color
    @href = href
    @type = type
    @disabled = disabled
    @options = options
  end

  def call
    if href.present? && !disabled
      render_as_link
    else
      render_as_button
    end
  end

  private

  def render_as_link
    link_to(href, class: classes, **options.except(:class)) do
      render_touch_target
    end
  end

  def render_as_button
    tag.button(
      type: type,
      disabled: disabled,
      class: classes,
      **options.except(:class)
    ) do
      render_touch_target
    end
  end

  def render_touch_target
    # Touch target for mobile accessibility (44x44px minimum)
    touch_target = tag.span(
      class: "absolute top-1/2 left-1/2 size-[max(100%,2.75rem)] -translate-x-1/2 -translate-y-1/2 pointer-fine:hidden",
      "aria-hidden": "true"
    )
    safe_join([touch_target, content])
  end

  def classes
    class_names(
      base_classes,
      variant_classes_for_current,
      disabled_classes,
      options[:class]
    )
  end

  def base_classes
    [
      "relative isolate inline-flex items-center justify-center gap-x-2",
      "rounded-lg border text-base/6 font-semibold",
      "px-3.5 py-2.5 sm:px-3 sm:py-1.5 sm:text-sm/6",
      "focus:outline-none focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-blue-500",
      "transition-colors"
    ]
  end

  def variant_classes_for_current
    case variant
    when :outline
      OUTLINE_CLASSES
    when :plain
      PLAIN_CLASSES
    else
      solid_color_classes
    end
  end

  def solid_color_classes
    [
      "border-transparent shadow-sm",
      variant_classes(SOLID_COLORS, color, :olive)
    ]
  end

  def disabled_classes
    "opacity-50 cursor-not-allowed" if disabled
  end
end
