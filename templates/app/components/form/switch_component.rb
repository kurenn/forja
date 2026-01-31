# frozen_string_literal: true

module Form
  # Renders a styled toggle switch
  #
  # @example Basic switch
  #   <%= render Form::SwitchComponent.new(name: "notifications") %>
  #
  # @example Colored switch
  #   <%= render Form::SwitchComponent.new(name: "feature", color: :green) %>
  #
  # @example Checked by default
  #   <%= render Form::SwitchComponent.new(name: "enabled", checked: true) %>
  #
  # @param name [String] Switch name attribute
  # @param value [String] Switch value when checked
  # @param checked [Boolean] Whether the switch is on
  # @param color [Symbol] Switch color when on
  # @param disabled [Boolean] Whether the switch is disabled
  # @param class [String] Additional CSS classes
  class SwitchComponent < ApplicationComponent
    COLORS = {
      olive: [
        "[--switch-bg-ring:var(--color-olive-700)]/90 [--switch-bg:var(--color-olive-600)] dark:[--switch-bg-ring:transparent]",
        "[--switch-shadow:var(--color-black)]/10 [--switch:white] [--switch-ring:var(--color-olive-700)]/90"
      ],
      red: [
        "[--switch-bg-ring:var(--color-red-700)]/90 [--switch-bg:var(--color-red-600)] dark:[--switch-bg-ring:transparent]",
        "[--switch:white] [--switch-ring:var(--color-red-700)]/90 [--switch-shadow:var(--color-red-900)]/20"
      ],
      orange: [
        "[--switch-bg-ring:var(--color-orange-600)]/90 [--switch-bg:var(--color-orange-500)] dark:[--switch-bg-ring:transparent]",
        "[--switch:white] [--switch-ring:var(--color-orange-600)]/90 [--switch-shadow:var(--color-orange-900)]/20"
      ],
      amber: [
        "[--switch-bg-ring:var(--color-amber-500)]/80 [--switch-bg:var(--color-amber-400)] dark:[--switch-bg-ring:transparent]",
        "[--switch-ring:transparent] [--switch-shadow:transparent] [--switch:var(--color-amber-950)]"
      ],
      yellow: [
        "[--switch-bg-ring:var(--color-yellow-400)]/80 [--switch-bg:var(--color-yellow-300)] dark:[--switch-bg-ring:transparent]",
        "[--switch-ring:transparent] [--switch-shadow:transparent] [--switch:var(--color-yellow-950)]"
      ],
      lime: [
        "[--switch-bg-ring:var(--color-lime-400)]/80 [--switch-bg:var(--color-lime-300)] dark:[--switch-bg-ring:transparent]",
        "[--switch-ring:transparent] [--switch-shadow:transparent] [--switch:var(--color-lime-950)]"
      ],
      green: [
        "[--switch-bg-ring:var(--color-green-700)]/90 [--switch-bg:var(--color-green-600)] dark:[--switch-bg-ring:transparent]",
        "[--switch:white] [--switch-ring:var(--color-green-700)]/90 [--switch-shadow:var(--color-green-900)]/20"
      ],
      emerald: [
        "[--switch-bg-ring:var(--color-emerald-600)]/90 [--switch-bg:var(--color-emerald-500)] dark:[--switch-bg-ring:transparent]",
        "[--switch:white] [--switch-ring:var(--color-emerald-600)]/90 [--switch-shadow:var(--color-emerald-900)]/20"
      ],
      teal: [
        "[--switch-bg-ring:var(--color-teal-700)]/90 [--switch-bg:var(--color-teal-600)] dark:[--switch-bg-ring:transparent]",
        "[--switch:white] [--switch-ring:var(--color-teal-700)]/90 [--switch-shadow:var(--color-teal-900)]/20"
      ],
      cyan: [
        "[--switch-bg-ring:var(--color-cyan-400)]/80 [--switch-bg:var(--color-cyan-300)] dark:[--switch-bg-ring:transparent]",
        "[--switch-ring:transparent] [--switch-shadow:transparent] [--switch:var(--color-cyan-950)]"
      ],
      sky: [
        "[--switch-bg-ring:var(--color-sky-600)]/80 [--switch-bg:var(--color-sky-500)] dark:[--switch-bg-ring:transparent]",
        "[--switch:white] [--switch-ring:var(--color-sky-600)]/80 [--switch-shadow:var(--color-sky-900)]/20"
      ],
      blue: [
        "[--switch-bg-ring:var(--color-blue-700)]/90 [--switch-bg:var(--color-blue-600)] dark:[--switch-bg-ring:transparent]",
        "[--switch:white] [--switch-ring:var(--color-blue-700)]/90 [--switch-shadow:var(--color-blue-900)]/20"
      ],
      indigo: [
        "[--switch-bg-ring:var(--color-indigo-600)]/90 [--switch-bg:var(--color-indigo-500)] dark:[--switch-bg-ring:transparent]",
        "[--switch:white] [--switch-ring:var(--color-indigo-600)]/90 [--switch-shadow:var(--color-indigo-900)]/20"
      ],
      violet: [
        "[--switch-bg-ring:var(--color-violet-600)]/90 [--switch-bg:var(--color-violet-500)] dark:[--switch-bg-ring:transparent]",
        "[--switch:white] [--switch-ring:var(--color-violet-600)]/90 [--switch-shadow:var(--color-violet-900)]/20"
      ],
      purple: [
        "[--switch-bg-ring:var(--color-purple-600)]/90 [--switch-bg:var(--color-purple-500)] dark:[--switch-bg-ring:transparent]",
        "[--switch:white] [--switch-ring:var(--color-purple-600)]/90 [--switch-shadow:var(--color-purple-900)]/20"
      ],
      fuchsia: [
        "[--switch-bg-ring:var(--color-fuchsia-600)]/90 [--switch-bg:var(--color-fuchsia-500)] dark:[--switch-bg-ring:transparent]",
        "[--switch:white] [--switch-ring:var(--color-fuchsia-600)]/90 [--switch-shadow:var(--color-fuchsia-900)]/20"
      ],
      pink: [
        "[--switch-bg-ring:var(--color-pink-600)]/90 [--switch-bg:var(--color-pink-500)] dark:[--switch-bg-ring:transparent]",
        "[--switch:white] [--switch-ring:var(--color-pink-600)]/90 [--switch-shadow:var(--color-pink-900)]/20"
      ],
      rose: [
        "[--switch-bg-ring:var(--color-rose-600)]/90 [--switch-bg:var(--color-rose-500)] dark:[--switch-bg-ring:transparent]",
        "[--switch:white] [--switch-ring:var(--color-rose-600)]/90 [--switch-shadow:var(--color-rose-900)]/20"
      ]
    }.freeze

    attr_reader :name, :value, :checked, :color, :disabled, :options

    def initialize(name: nil, value: "1", checked: false, color: :olive, disabled: false, **options)
      @name = name
      @value = value
      @checked = checked
      @color = color
      @disabled = disabled
      @options = options
    end

    def call
      tag.label(
        data: { slot: "control", controller: "switch" },
        class: label_classes
      ) do
        safe_join([
          # Hidden input for form submission when unchecked
          tag.input(type: "hidden", name: name, value: "0"),
          tag.input(
            type: "checkbox",
            name: name,
            value: value,
            checked: checked || nil,
            disabled: disabled || nil,
            role: "switch",
            "aria-checked": checked.to_s,
            data: { switch_target: "input", action: "switch#toggle" },
            class: "peer sr-only",
            **options.except(:class)
          ),
          switch_track
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

    def switch_track
      tag.span(
        "aria-hidden": "true",
        class: track_classes
      ) do
        switch_thumb
      end
    end

    def track_classes
      class_names(
        # Base styles
        "relative isolate inline-flex h-6 w-10 rounded-full p-[3px] sm:h-5 sm:w-8",
        # Transitions
        "transition duration-200 ease-in-out",
        # Outline and background color in forced-colors mode
        "forced-colors:outline forced-colors:[--switch-bg:Highlight] dark:forced-colors:[--switch-bg:Highlight]",
        # Unchecked
        "bg-olive-200 ring-1 ring-black/5 ring-inset dark:bg-white/5 dark:ring-white/15",
        # Checked
        "peer-checked:bg-[--switch-bg] peer-checked:ring-[--switch-bg-ring] dark:peer-checked:bg-[--switch-bg] dark:peer-checked:ring-[--switch-bg-ring]",
        # Focus
        "peer-focus-visible:outline-2 peer-focus-visible:outline-offset-2 peer-focus-visible:outline-blue-500",
        # Hover
        "hover:ring-black/15 hover:peer-checked:ring-[--switch-bg-ring]",
        "dark:hover:ring-white/25 dark:hover:peer-checked:ring-[--switch-bg-ring]",
        # Disabled
        classes_if(disabled, "bg-olive-200 opacity-50 peer-checked:bg-olive-200 peer-checked:ring-black/5 dark:bg-white/15 dark:peer-checked:bg-white/15 dark:peer-checked:ring-white/15"),
        # Color specific styles
        color_classes
      )
    end

    def switch_thumb
      tag.span(class: thumb_classes)
    end

    def thumb_classes
      class_names(
        # Basic layout
        "pointer-events-none relative inline-block size-[1.125rem] rounded-full sm:size-3.5",
        # Transition
        "translate-x-0 transition duration-200 ease-in-out",
        # Invisible border for forced-colors mode
        "border border-transparent",
        # Unchecked
        "bg-white shadow-sm ring-1 ring-black/5",
        # Checked
        "peer-checked:group-[]:bg-[--switch] peer-checked:group-[]:shadow-[--switch-shadow] peer-checked:group-[]:ring-[--switch-ring]",
        "peer-checked:group-[]:translate-x-4 sm:peer-checked:group-[]:translate-x-3",
        # Disabled
        classes_if(disabled, "peer-checked:group-[]:bg-white peer-checked:group-[]:shadow-sm peer-checked:group-[]:ring-black/5")
      )
    end

    def color_classes
      colors = COLORS[color] || COLORS[:olive]
      colors.is_a?(Array) ? colors.join(" ") : colors
    end
  end
end
