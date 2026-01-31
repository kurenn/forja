# frozen_string_literal: true

module Form
  # Renders a styled radio input
  #
  # @example Basic radio
  #   <%= render Form::RadioComponent.new(name: "plan", value: "basic") %>
  #
  # @example Colored radio
  #   <%= render Form::RadioComponent.new(name: "plan", value: "pro", color: :green) %>
  #
  # @param name [String] Radio name attribute
  # @param value [String] Radio value
  # @param checked [Boolean] Whether the radio is checked
  # @param color [Symbol] Radio color when checked
  # @param disabled [Boolean] Whether the radio is disabled
  # @param class [String] Additional CSS classes
  class RadioComponent < ApplicationComponent
    COLORS = {
      olive: "[--radio-checked-bg:var(--color-olive-600)] [--radio-checked-border:var(--color-olive-700)]/90 [--radio-checked-indicator:var(--color-white)]",
      red: "[--radio-checked-indicator:var(--color-white)] [--radio-checked-bg:var(--color-red-600)] [--radio-checked-border:var(--color-red-700)]/90",
      orange: "[--radio-checked-indicator:var(--color-white)] [--radio-checked-bg:var(--color-orange-500)] [--radio-checked-border:var(--color-orange-600)]/90",
      amber: "[--radio-checked-bg:var(--color-amber-400)] [--radio-checked-border:var(--color-amber-500)]/80 [--radio-checked-indicator:var(--color-amber-950)]",
      yellow: "[--radio-checked-bg:var(--color-yellow-300)] [--radio-checked-border:var(--color-yellow-400)]/80 [--radio-checked-indicator:var(--color-yellow-950)]",
      lime: "[--radio-checked-bg:var(--color-lime-300)] [--radio-checked-border:var(--color-lime-400)]/80 [--radio-checked-indicator:var(--color-lime-950)]",
      green: "[--radio-checked-indicator:var(--color-white)] [--radio-checked-bg:var(--color-green-600)] [--radio-checked-border:var(--color-green-700)]/90",
      emerald: "[--radio-checked-indicator:var(--color-white)] [--radio-checked-bg:var(--color-emerald-600)] [--radio-checked-border:var(--color-emerald-700)]/90",
      teal: "[--radio-checked-indicator:var(--color-white)] [--radio-checked-bg:var(--color-teal-600)] [--radio-checked-border:var(--color-teal-700)]/90",
      cyan: "[--radio-checked-bg:var(--color-cyan-300)] [--radio-checked-border:var(--color-cyan-400)]/80 [--radio-checked-indicator:var(--color-cyan-950)]",
      sky: "[--radio-checked-indicator:var(--color-white)] [--radio-checked-bg:var(--color-sky-500)] [--radio-checked-border:var(--color-sky-600)]/80",
      blue: "[--radio-checked-indicator:var(--color-white)] [--radio-checked-bg:var(--color-blue-600)] [--radio-checked-border:var(--color-blue-700)]/90",
      indigo: "[--radio-checked-indicator:var(--color-white)] [--radio-checked-bg:var(--color-indigo-500)] [--radio-checked-border:var(--color-indigo-600)]/90",
      violet: "[--radio-checked-indicator:var(--color-white)] [--radio-checked-bg:var(--color-violet-500)] [--radio-checked-border:var(--color-violet-600)]/90",
      purple: "[--radio-checked-indicator:var(--color-white)] [--radio-checked-bg:var(--color-purple-500)] [--radio-checked-border:var(--color-purple-600)]/90",
      fuchsia: "[--radio-checked-indicator:var(--color-white)] [--radio-checked-bg:var(--color-fuchsia-500)] [--radio-checked-border:var(--color-fuchsia-600)]/90",
      pink: "[--radio-checked-indicator:var(--color-white)] [--radio-checked-bg:var(--color-pink-500)] [--radio-checked-border:var(--color-pink-600)]/90",
      rose: "[--radio-checked-indicator:var(--color-white)] [--radio-checked-bg:var(--color-rose-500)] [--radio-checked-border:var(--color-rose-600)]/90"
    }.freeze

    attr_reader :name, :value, :checked, :color, :disabled, :options

    def initialize(name: nil, value: nil, checked: false, color: :olive, disabled: false, **options)
      @name = name
      @value = value
      @checked = checked
      @color = color
      @disabled = disabled
      @options = options
    end

    def call
      tag.label(
        data: { slot: "control" },
        class: label_classes
      ) do
        safe_join([
          tag.input(
            type: "radio",
            name: name,
            value: value,
            checked: checked || nil,
            disabled: disabled || nil,
            class: "peer sr-only",
            **options.except(:class)
          ),
          radio_visual
        ])
      end
    end

    private

    def label_classes
      class_names(
        "group inline-flex cursor-pointer focus-within:outline-none",
        classes_if(disabled, "cursor-not-allowed"),
        options[:class]
      )
    end

    def radio_visual
      tag.span(class: radio_classes) do
        tag.span(class: indicator_classes)
      end
    end

    def radio_classes
      class_names(
        # Basic layout
        "relative isolate flex size-[1.1875rem] shrink-0 rounded-full sm:size-[1.0625rem]",
        # Background color + shadow applied to inset pseudo element
        "before:absolute before:inset-0 before:-z-10 before:rounded-full before:bg-white before:shadow-sm",
        # Background color when checked
        "peer-checked:before:bg-[--radio-checked-bg]",
        # Hide before pseudo in dark mode
        "dark:before:hidden",
        # Background color applied to control in dark mode
        "dark:bg-white/5 dark:peer-checked:bg-[--radio-checked-bg]",
        # Border
        "border border-olive-950/15 peer-checked:border-transparent peer-checked:bg-[--radio-checked-border]",
        "hover:border-olive-950/30 peer-checked:hover:border-transparent",
        "dark:border-white/15 dark:peer-checked:border-white/5 dark:hover:border-white/30 dark:peer-checked:hover:border-white/5",
        # Inner highlight shadow
        "after:absolute after:inset-0 after:rounded-full after:shadow-[inset_0_1px_theme(colors.white/15%)]",
        "dark:after:-inset-px dark:after:hidden dark:after:rounded-full dark:peer-checked:after:block",
        # Indicator color (light mode)
        "[--radio-indicator:transparent] peer-checked:[--radio-indicator:var(--radio-checked-indicator)]",
        "hover:peer-checked:[--radio-indicator:var(--radio-checked-indicator)] hover:[--radio-indicator:theme(colors.olive.900/10%)]",
        # Indicator color (dark mode)
        "dark:hover:peer-checked:[--radio-indicator:var(--radio-checked-indicator)] dark:hover:[--radio-indicator:theme(colors.olive.700)]",
        # Focus ring
        "peer-focus-visible:outline peer-focus-visible:outline-2 peer-focus-visible:outline-offset-2 peer-focus-visible:outline-blue-500",
        # Disabled state
        classes_if(disabled, "opacity-50 border-olive-950/25 bg-olive-950/5 [--radio-checked-indicator:theme(colors.olive.950)]/50 before:bg-transparent dark:border-white/20 dark:bg-white/[0.025] dark:[--radio-checked-indicator:theme(colors.white)]/50 dark:peer-checked:after:hidden"),
        # Color specific
        variant_classes(COLORS, color, :olive)
      )
    end

    def indicator_classes
      class_names(
        "size-full rounded-full border-[4.5px] border-transparent bg-[--radio-indicator] bg-clip-padding",
        # Forced colors mode
        "forced-colors:border-[Canvas] forced-colors:peer-checked:group-[]:border-[Highlight]"
      )
    end
  end
end
