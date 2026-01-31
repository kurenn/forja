# frozen_string_literal: true

module Form
  # Groups multiple form fields with consistent spacing
  #
  # @example Group of fields
  #   <%= render Form::FieldGroupComponent.new do %>
  #     <%= render Form::FieldComponent.new do %>
  #       <!-- field content -->
  #     <% end %>
  #   <% end %>
  #
  # @param class [String] Additional CSS classes
  class FieldGroupComponent < ApplicationComponent
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
        "space-y-8",
        options[:class]
      )
    end
  end
end
