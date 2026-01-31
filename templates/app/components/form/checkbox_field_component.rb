# frozen_string_literal: true

module Form
  # Wraps a checkbox with label and optional description
  #
  # @example Checkbox with label
  #   <%= render Form::CheckboxFieldComponent.new do %>
  #     <%= render Form::CheckboxComponent.new(name: "agree") %>
  #     <%= render Form::LabelComponent.new { "I agree" } %>
  #   <% end %>
  #
  # @param class [String] Additional CSS classes
  class CheckboxFieldComponent < ApplicationComponent
    attr_reader :options

    def initialize(**options)
      @options = options
    end

    def call
      tag.div(content, data: { slot: "field" }, class: field_classes, **options.except(:class))
    end

    private

    def field_classes
      class_names(
        # Base layout
        "grid grid-cols-[1.125rem_1fr] gap-x-4 gap-y-1 sm:grid-cols-[1rem_1fr]",
        # Control layout
        "*:data-[slot=control]:col-start-1 *:data-[slot=control]:row-start-1 *:data-[slot=control]:mt-0.5 sm:*:data-[slot=control]:mt-1",
        # Label layout
        "*:data-[slot=label]:col-start-2 *:data-[slot=label]:row-start-1",
        # Description layout
        "*:data-[slot=description]:col-start-2 *:data-[slot=description]:row-start-2",
        # With description
        "has-[data-slot=description]:**:data-[slot=label]:font-medium",
        options[:class]
      )
    end
  end
end
