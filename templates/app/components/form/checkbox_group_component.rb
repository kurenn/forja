# frozen_string_literal: true

module Form
  # Groups multiple checkbox fields with consistent spacing
  #
  # @example Group of checkboxes
  #   <%= render Form::CheckboxGroupComponent.new do %>
  #     <%= render Form::CheckboxFieldComponent.new do %>
  #       <%= render Form::CheckboxComponent.new(name: "features[]", value: "a") %>
  #       <%= render Form::LabelComponent.new { "Feature A" } %>
  #     <% end %>
  #   <% end %>
  #
  # @param class [String] Additional CSS classes
  class CheckboxGroupComponent < ApplicationComponent
    attr_reader :options

    def initialize(**options)
      @options = options
    end

    def call
      tag.div(content, data: { slot: "control" }, class: group_classes, **options.except(:class))
    end

    private

    def group_classes
      class_names(
        # Basic groups
        "space-y-3",
        # With descriptions
        "has-[data-slot=description]:space-y-6 has-[data-slot=description]:**:data-[slot=label]:font-medium",
        options[:class]
      )
    end
  end
end
