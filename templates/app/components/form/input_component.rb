# frozen_string_literal: true

module Form
  # Renders a styled text input field
  #
  # @example Basic input
  #   <%= render Form::InputComponent.new(name: "email", type: "email") %>
  #
  # @example Input with placeholder
  #   <%= render Form::InputComponent.new(name: "email", placeholder: "you@example.com") %>
  #
  # @example Disabled input
  #   <%= render Form::InputComponent.new(name: "email", disabled: true) %>
  #
  # @param name [String] Input name attribute
  # @param type [String] Input type (text, email, password, etc.)
  # @param value [String] Input value
  # @param placeholder [String] Placeholder text
  # @param disabled [Boolean] Whether the input is disabled
  # @param invalid [Boolean] Whether the input has validation errors
  # @param class [String] Additional CSS classes
  class InputComponent < ApplicationComponent
    DATE_TYPES = %w[date datetime-local month time week].freeze

    attr_reader :name, :type, :value, :placeholder, :disabled, :invalid, :options

    def initialize(name: nil, type: "text", value: nil, placeholder: nil, disabled: false, invalid: false, **options)
      @name = name
      @type = type
      @value = value
      @placeholder = placeholder
      @disabled = disabled
      @invalid = invalid
      @options = options
    end

    def call
      tag.span(data: { slot: "control" }, class: wrapper_classes) do
        tag.input(
          type: type,
          name: name,
          value: value,
          placeholder: placeholder,
          disabled: disabled || nil,
          data: input_data_attributes,
          class: input_classes,
          **options.except(:class)
        )
      end
    end

    private

    def wrapper_classes
      class_names(
        # Basic layout
        "relative block w-full",
        # Background color + shadow applied to inset pseudo element
        "before:absolute before:inset-px before:rounded-[calc(var(--radius-lg)-1px)] before:bg-white before:shadow-sm",
        # Hide before pseudo in dark mode
        "dark:before:hidden",
        # Focus ring
        "after:pointer-events-none after:absolute after:inset-0 after:rounded-lg after:ring-transparent after:ring-inset sm:focus-within:after:ring-2 sm:focus-within:after:ring-olive-900",
        # Disabled state
        classes_if(disabled, "opacity-50 before:bg-olive-950/5 before:shadow-none"),
        options[:class]
      )
    end

    def input_classes
      class_names(
        # Date type specific classes
        date_type_classes,
        # Basic layout
        "relative block w-full appearance-none rounded-lg px-[calc(theme(spacing[3.5])-1px)] py-[calc(theme(spacing[2.5])-1px)] sm:px-[calc(theme(spacing.3)-1px)] sm:py-[calc(theme(spacing[1.5])-1px)]",
        # Typography
        "text-base/6 text-olive-950 placeholder:text-olive-500 sm:text-sm/6 dark:text-white",
        # Border
        "border border-olive-950/10 hover:border-olive-950/20 dark:border-white/10 dark:hover:border-white/20",
        # Background color
        "bg-transparent dark:bg-white/5",
        # Hide default focus styles
        "focus:outline-none",
        # Invalid state
        classes_if(invalid, "border-red-500 hover:border-red-500 dark:border-red-600 dark:hover:border-red-600"),
        # Disabled state
        classes_if(disabled, "border-olive-950/20 dark:border-white/15 dark:bg-white/[0.025] dark:hover:border-white/15"),
        # System icons (for date inputs)
        "dark:[color-scheme:dark]"
      )
    end

    def input_data_attributes
      attrs = {}
      attrs[:disabled] = "" if disabled
      attrs[:invalid] = "" if invalid
      attrs
    end

    def date_type_classes
      return "" unless DATE_TYPES.include?(type)

      [
        "[&::-webkit-datetime-edit-fields-wrapper]:p-0",
        "[&::-webkit-date-and-time-value]:min-h-[1.5em]",
        "[&::-webkit-datetime-edit]:inline-flex",
        "[&::-webkit-datetime-edit]:p-0",
        "[&::-webkit-datetime-edit-year-field]:p-0",
        "[&::-webkit-datetime-edit-month-field]:p-0",
        "[&::-webkit-datetime-edit-day-field]:p-0",
        "[&::-webkit-datetime-edit-hour-field]:p-0",
        "[&::-webkit-datetime-edit-minute-field]:p-0",
        "[&::-webkit-datetime-edit-second-field]:p-0",
        "[&::-webkit-datetime-edit-millisecond-field]:p-0",
        "[&::-webkit-datetime-edit-meridiem-field]:p-0"
      ].join(" ")
    end
  end
end
