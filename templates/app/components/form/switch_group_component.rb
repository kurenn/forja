# frozen_string_literal: true

module Form
  # Groups multiple switch fields with consistent spacing
  #
  # @example Group of switches
  #   <%= render Form::SwitchGroupComponent.new do %>
  #     <%= render Form::SwitchFieldComponent.new do %>
  #       <%= render Form::LabelComponent.new { "Notifications" } %>
  #       <%= render Form::SwitchComponent.new(name: "notifications") %>
  #     <% end %>
  #   <% end %>
  #
  # @param class [String] Additional CSS classes
  class SwitchGroupComponent < ApplicationComponent
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
        "space-y-3 **:data-[slot=label]:font-normal",
        # With descriptions
        "has-[data-slot=description]:space-y-6 has-[data-slot=description]:**:data-[slot=label]:font-medium",
        options[:class]
      )
    end
  end
end
