# frozen_string_literal: true

module Form
  # Wraps a switch with label and optional description
  #
  # @example Switch with label
  #   <%= render Form::SwitchFieldComponent.new do %>
  #     <%= render Form::LabelComponent.new { "Notifications" } %>
  #     <%= render Form::SwitchComponent.new(name: "notifications") %>
  #   <% end %>
  #
  # @param class [String] Additional CSS classes
  class SwitchFieldComponent < ApplicationComponent
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
        "grid grid-cols-[1fr_auto] gap-x-8 gap-y-1",
        # Control layout
        "*:data-[slot=control]:col-start-2 *:data-[slot=control]:self-start sm:*:data-[slot=control]:mt-0.5",
        # Label layout
        "*:data-[slot=label]:col-start-1 *:data-[slot=label]:row-start-1",
        # Description layout
        "*:data-[slot=description]:col-start-1 *:data-[slot=description]:row-start-2",
        # With description
        "has-[data-slot=description]:**:data-[slot=label]:font-medium",
        options[:class]
      )
    end
  end
end
