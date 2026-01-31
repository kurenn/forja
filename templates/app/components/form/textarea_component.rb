# frozen_string_literal: true

module Form
  # Renders a styled textarea field
  #
  # @example Basic textarea
  #   <%= render Form::TextareaComponent.new(name: "bio") %>
  #
  # @example Non-resizable textarea
  #   <%= render Form::TextareaComponent.new(name: "bio", resizable: false) %>
  #
  # @param name [String] Textarea name attribute
  # @param value [String] Textarea value
  # @param placeholder [String] Placeholder text
  # @param rows [Integer] Number of visible text lines
  # @param resizable [Boolean] Whether the textarea is resizable
  # @param disabled [Boolean] Whether the textarea is disabled
  # @param invalid [Boolean] Whether the textarea has validation errors
  # @param class [String] Additional CSS classes
  class TextareaComponent < ApplicationComponent
    attr_reader :name, :value, :placeholder, :rows, :resizable, :disabled, :invalid, :options

    def initialize(name: nil, value: nil, placeholder: nil, rows: 3, resizable: true, disabled: false, invalid: false, **options)
      @name = name
      @value = value
      @placeholder = placeholder
      @rows = rows
      @resizable = resizable
      @disabled = disabled
      @invalid = invalid
      @options = options
    end

    def call
      tag.span(data: { slot: "control" }, class: wrapper_classes) do
        tag.textarea(
          value,
          name: name,
          placeholder: placeholder,
          rows: rows,
          disabled: disabled || nil,
          data: textarea_data_attributes,
          class: textarea_classes,
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

    def textarea_classes
      class_names(
        # Basic layout
        "relative block h-full w-full appearance-none rounded-lg px-[calc(theme(spacing[3.5])-1px)] py-[calc(theme(spacing[2.5])-1px)] sm:px-[calc(theme(spacing.3)-1px)] sm:py-[calc(theme(spacing[1.5])-1px)]",
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
        # Resizable
        resizable ? "resize-y" : "resize-none"
      )
    end

    def textarea_data_attributes
      attrs = {}
      attrs[:disabled] = "" if disabled
      attrs[:invalid] = "" if invalid
      attrs
    end
  end
end
