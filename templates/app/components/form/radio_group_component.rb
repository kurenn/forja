# frozen_string_literal: true

module Form
  # Groups multiple radio fields with consistent spacing
  #
  # @example Group of radio buttons
  #   <%= render Form::RadioGroupComponent.new do %>
  #     <%= render Form::RadioFieldComponent.new do %>
  #       <%= render Form::RadioComponent.new(name: "plan", value: "basic") %>
  #       <%= render Form::LabelComponent.new { "Basic" } %>
  #     <% end %>
  #   <% end %>
  #
  # @param class [String] Additional CSS classes
  class RadioGroupComponent < ApplicationComponent
    attr_reader :options

    def initialize(**options)
      @options = options
    end

    def call
      tag.div(content, data: { slot: "control" }, role: "radiogroup", class: group_classes, **options.except(:class))
    end

    private

    def group_classes
      class_names(
        # Basic groups
        "space-y-3 **:data-[slot=label]:font-normal",
        # With descriptions
        "has-[data-slot=description]:space-y-6 has-[data-slot=description]:**:data-[slot=label]:font-medium",
        options[:class]
      )
    end
  end
end
