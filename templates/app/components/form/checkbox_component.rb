# frozen_string_literal: true

module Form
  # Renders a styled checkbox input
  #
  # @example Basic checkbox
  #   <%= render Form::CheckboxComponent.new(name: "agree") %>
  #
  # @example Colored checkbox
  #   <%= render Form::CheckboxComponent.new(name: "feature", color: :green) %>
  #
  # @example Checked by default
  #   <%= render Form::CheckboxComponent.new(name: "subscribe", checked: true) %>
  #
  # @param name [String] Checkbox name attribute
  # @param value [String] Checkbox value
  # @param checked [Boolean] Whether the checkbox is checked
  # @param indeterminate [Boolean] Whether the checkbox is in indeterminate state
  # @param color [Symbol] Checkbox color when checked
  # @param disabled [Boolean] Whether the checkbox is disabled
  # @param class [String] Additional CSS classes
  class CheckboxComponent < ApplicationComponent
    COLORS = {
      olive: "[--checkbox-check:var(--color-white)] [--checkbox-checked-bg:var(--color-olive-600)] [--checkbox-checked-border:var(--color-olive-700)]/90",
      red: "[--checkbox-check:var(--color-white)] [--checkbox-checked-bg:var(--color-red-600)] [--checkbox-checked-border:var(--color-red-700)]/90",
      orange: "[--checkbox-check:var(--color-white)] [--checkbox-checked-bg:var(--color-orange-500)] [--checkbox-checked-border:var(--color-orange-600)]/90",
      amber: "[--checkbox-check:var(--color-amber-950)] [--checkbox-checked-bg:var(--color-amber-400)] [--checkbox-checked-border:var(--color-amber-500)]/80",
      yellow: "[--checkbox-check:var(--color-yellow-950)] [--checkbox-checked-bg:var(--color-yellow-300)] [--checkbox-checked-border:var(--color-yellow-400)]/80",
      lime: "[--checkbox-check:var(--color-lime-950)] [--checkbox-checked-bg:var(--color-lime-300)] [--checkbox-checked-border:var(--color-lime-400)]/80",
      green: "[--checkbox-check:var(--color-white)] [--checkbox-checked-bg:var(--color-green-600)] [--checkbox-checked-border:var(--color-green-700)]/90",
      emerald: "[--checkbox-check:var(--color-white)] [--checkbox-checked-bg:var(--color-emerald-600)] [--checkbox-checked-border:var(--color-emerald-700)]/90",
      teal: "[--checkbox-check:var(--color-white)] [--checkbox-checked-bg:var(--color-teal-600)] [--checkbox-checked-border:var(--color-teal-700)]/90",
      cyan: "[--checkbox-check:var(--color-cyan-950)] [--checkbox-checked-bg:var(--color-cyan-300)] [--checkbox-checked-border:var(--color-cyan-400)]/80",
      sky: "[--checkbox-check:var(--color-white)] [--checkbox-checked-bg:var(--color-sky-500)] [--checkbox-checked-border:var(--color-sky-600)]/80",
      blue: "[--checkbox-check:var(--color-white)] [--checkbox-checked-bg:var(--color-blue-600)] [--checkbox-checked-border:var(--color-blue-700)]/90",
      indigo: "[--checkbox-check:var(--color-white)] [--checkbox-checked-bg:var(--color-indigo-500)] [--checkbox-checked-border:var(--color-indigo-600)]/90",
      violet: "[--checkbox-check:var(--color-white)] [--checkbox-checked-bg:var(--color-violet-500)] [--checkbox-checked-border:var(--color-violet-600)]/90",
      purple: "[--checkbox-check:var(--color-white)] [--checkbox-checked-bg:var(--color-purple-500)] [--checkbox-checked-border:var(--color-purple-600)]/90",
      fuchsia: "[--checkbox-check:var(--color-white)] [--checkbox-checked-bg:var(--color-fuchsia-500)] [--checkbox-checked-border:var(--color-fuchsia-600)]/90",
      pink: "[--checkbox-check:var(--color-white)] [--checkbox-checked-bg:var(--color-pink-500)] [--checkbox-checked-border:var(--color-pink-600)]/90",
      rose: "[--checkbox-check:var(--color-white)] [--checkbox-checked-bg:var(--color-rose-500)] [--checkbox-checked-border:var(--color-rose-600)]/90"
    }.freeze

    attr_reader :name, :value, :checked, :indeterminate, :color, :disabled, :options

    def initialize(name: nil, value: "1", checked: false, indeterminate: false, color: :olive, disabled: false, **options)
      @name = name
      @value = value
      @checked = checked
      @indeterminate = indeterminate
      @color = color
      @disabled = disabled
      @options = options
    end

    def call
      tag.label(
        data: { slot: "control", controller: "checkbox" },
        class: label_classes
      ) do
        safe_join([
          tag.input(
            type: "checkbox",
            name: name,
            value: value,
            checked: checked || nil,
            disabled: disabled || nil,
            data: input_data_attributes,
            class: "peer sr-only",
            **options.except(:class)
          ),
          checkbox_visual
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

    def input_data_attributes
      attrs = { checkbox_target: "input" }
      attrs[:action] = "checkbox#toggle"
      attrs
    end

    def checkbox_visual
      tag.span(class: checkbox_classes) do
        checkmark_svg
      end
    end

    def checkbox_classes
      class_names(
        # Basic layout
        "relative isolate flex size-[1.125rem] items-center justify-center rounded-[0.3125rem] sm:size-4",
        # Background color + shadow applied to inset pseudo element
        "before:absolute before:inset-0 before:-z-10 before:rounded-[calc(0.3125rem-1px)] before:bg-white before:shadow-sm",
        # Background color when checked
        "peer-checked:before:bg-[--checkbox-checked-bg]",
        # Hide before pseudo in dark mode
        "dark:before:hidden",
        # Background color applied to control in dark mode
        "dark:bg-white/5 dark:peer-checked:bg-[--checkbox-checked-bg]",
        # Border
        "border border-olive-950/15 peer-checked:border-transparent peer-checked:bg-[--checkbox-checked-border]",
        "hover:border-olive-950/30 peer-checked:hover:border-transparent",
        "dark:border-white/15 dark:peer-checked:border-white/5 dark:hover:border-white/30 dark:peer-checked:hover:border-white/5",
        # Inner highlight shadow
        "after:absolute after:inset-0 after:rounded-[calc(0.3125rem-1px)] after:shadow-[inset_0_1px_theme(colors.white/15%)]",
        "dark:after:-inset-px dark:after:hidden dark:after:rounded-[0.3125rem] dark:peer-checked:after:block",
        # Focus ring
        "peer-focus-visible:outline-2 peer-focus-visible:outline-offset-2 peer-focus-visible:outline-blue-500",
        # Disabled state
        classes_if(disabled, "opacity-50 border-olive-950/25 bg-olive-950/5 [--checkbox-check:theme(colors.olive.950)]/50 before:bg-transparent dark:border-white/20 dark:bg-white/[0.025] dark:[--checkbox-check:theme(colors.white)]/50 dark:peer-checked:after:hidden"),
        # Forced colors mode
        "forced-colors:[--checkbox-check:HighlightText] forced-colors:[--checkbox-checked-bg:Highlight]",
        # Color specific
        variant_classes(COLORS, color, :olive)
      )
    end

    def checkmark_svg
      tag.svg(
        viewBox: "0 0 14 14",
        fill: "none",
        class: "size-4 stroke-[--checkbox-check] opacity-0 peer-checked:group-[]:opacity-100 sm:size-3.5"
      ) do
        safe_join([
          # Checkmark path
          tag.path(
            d: "M3 8L6 11L11 3.5",
            "stroke-width": "2",
            "stroke-linecap": "round",
            "stroke-linejoin": "round",
            class: classes_if(indeterminate, "opacity-0", "opacity-100")
          ),
          # Indeterminate path
          tag.path(
            d: "M3 7H11",
            "stroke-width": "2",
            "stroke-linecap": "round",
            "stroke-linejoin": "round",
            class: classes_if(indeterminate, "opacity-100", "opacity-0")
          )
        ])
      end
    end
  end
end
