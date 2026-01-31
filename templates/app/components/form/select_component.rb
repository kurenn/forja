# frozen_string_literal: true

module Form
  # Renders a styled native select field
  #
  # @example Basic select
  #   <%= render Form::SelectComponent.new(name: "country") do %>
  #     <option value="us">United States</option>
  #     <option value="ca">Canada</option>
  #   <% end %>
  #
  # @example Multiple select
  #   <%= render Form::SelectComponent.new(name: "countries", multiple: true) do %>
  #     <option value="us">United States</option>
  #     <option value="ca">Canada</option>
  #   <% end %>
  #
  # @param name [String] Select name attribute
  # @param multiple [Boolean] Whether multiple options can be selected
  # @param disabled [Boolean] Whether the select is disabled
  # @param invalid [Boolean] Whether the select has validation errors
  # @param class [String] Additional CSS classes
  class SelectComponent < ApplicationComponent
    attr_reader :name, :multiple, :disabled, :invalid, :options

    def initialize(name: nil, multiple: false, disabled: false, invalid: false, **options)
      @name = name
      @multiple = multiple
      @disabled = disabled
      @invalid = invalid
      @options = options
    end

    def call
      tag.span(data: { slot: "control" }, class: wrapper_classes) do
        safe_join([
          tag.select(
            content,
            name: name,
            multiple: multiple || nil,
            disabled: disabled || nil,
            data: select_data_attributes,
            class: select_classes,
            **options.except(:class)
          ),
          dropdown_icon
        ])
      end
    end

    private

    def wrapper_classes
      class_names(
        # Basic layout
        "group relative block w-full",
        # Background color + shadow applied to inset pseudo element
        "before:absolute before:inset-px before:rounded-[calc(var(--radius-lg)-1px)] before:bg-white before:shadow-sm",
        # Hide before pseudo in dark mode
        "dark:before:hidden",
        # Focus ring
        "after:pointer-events-none after:absolute after:inset-0 after:rounded-lg after:ring-transparent after:ring-inset has-[:focus]:after:ring-2 has-[:focus]:after:ring-olive-900",
        # Disabled state
        classes_if(disabled, "opacity-50 before:bg-olive-950/5 before:shadow-none"),
        options[:class]
      )
    end

    def select_classes
      class_names(
        # Basic layout
        "relative block w-full appearance-none rounded-lg py-[calc(theme(spacing[2.5])-1px)] sm:py-[calc(theme(spacing[1.5])-1px)]",
        # Horizontal padding
        multiple ? "px-[calc(theme(spacing[3.5])-1px)] sm:px-[calc(theme(spacing.3)-1px)]" : "pr-[calc(theme(spacing.10)-1px)] pl-[calc(theme(spacing[3.5])-1px)] sm:pr-[calc(theme(spacing.9)-1px)] sm:pl-[calc(theme(spacing.3)-1px)]",
        # Options (multi-select)
        "[&_optgroup]:font-semibold",
        # Typography
        "text-base/6 text-olive-950 placeholder:text-olive-500 sm:text-sm/6 dark:text-white dark:*:text-white",
        # Border
        "border border-olive-950/10 hover:border-olive-950/20 dark:border-white/10 dark:hover:border-white/20",
        # Background color
        "bg-transparent dark:bg-white/5 dark:*:bg-olive-800",
        # Hide default focus styles
        "focus:outline-none",
        # Invalid state
        classes_if(invalid, "border-red-500 hover:border-red-500 dark:border-red-600 dark:hover:border-red-600"),
        # Disabled state
        classes_if(disabled, "border-olive-950/20 opacity-100 dark:border-white/15 dark:bg-white/[0.025] dark:hover:border-white/15")
      )
    end

    def select_data_attributes
      attrs = {}
      attrs[:disabled] = "" if disabled
      attrs[:invalid] = "" if invalid
      attrs
    end

    def dropdown_icon
      return "" if multiple

      tag.span(class: "pointer-events-none absolute inset-y-0 right-0 flex items-center pr-2") do
        tag.svg(
          viewBox: "0 0 16 16",
          fill: "none",
          "aria-hidden": "true",
          class: "size-5 stroke-olive-500 group-has-[:disabled]:stroke-olive-600 sm:size-4 dark:stroke-olive-400 forced-colors:stroke-[CanvasText]"
        ) do
          safe_join([
            tag.path(d: "M5.75 10.75L8 13L10.25 10.75", "stroke-width": "1.5", "stroke-linecap": "round", "stroke-linejoin": "round"),
            tag.path(d: "M10.25 5.25L8 3L5.75 5.25", "stroke-width": "1.5", "stroke-linecap": "round", "stroke-linejoin": "round")
          ])
        end
      end
    end
  end
end
