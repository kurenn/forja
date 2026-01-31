# frozen_string_literal: true

module Form
  # Wraps a form control with proper spacing for label, description, and error
  #
  # @example Field with label and input
  #   <%= render Form::FieldComponent.new do %>
  #     <%= render Form::LabelComponent.new(for: "email") { "Email" } %>
  #     <%= render Form::InputComponent.new(id: "email", name: "email") %>
  #   <% end %>
  #
  # @param disabled [Boolean] Whether the field is disabled
  # @param class [String] Additional CSS classes
  class FieldComponent < ApplicationComponent
    attr_reader :disabled, :options

    def initialize(disabled: false, **options)
      @disabled = disabled
      @options = options
    end

    def call
      tag.div(content, data: data_attributes, class: field_classes, **options.except(:class))
    end

    private

    def data_attributes
      attrs = { slot: "field" }
      attrs[:disabled] = "" if disabled
      attrs
    end

    def field_classes
      class_names(
        # Label + control spacing
        "[&>[data-slot=label]+[data-slot=control]]:mt-3",
        # Label + description spacing
        "[&>[data-slot=label]+[data-slot=description]]:mt-1",
        # Description + control spacing
        "[&>[data-slot=description]+[data-slot=control]]:mt-3",
        # Control + description spacing
        "[&>[data-slot=control]+[data-slot=description]]:mt-3",
        # Control + error spacing
        "[&>[data-slot=control]+[data-slot=error]]:mt-3",
        # Label styling within field
        "*:data-[slot=label]:font-medium",
        # Disabled state
        classes_if(disabled, "opacity-50"),
        options[:class]
      )
    end
  end
end
