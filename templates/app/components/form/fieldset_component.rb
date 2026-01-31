# frozen_string_literal: true

module Form
  # Renders a fieldset for grouping related form fields
  #
  # @example Fieldset with legend
  #   <%= render Form::FieldsetComponent.new do %>
  #     <%= render Form::LegendComponent.new { "Contact Information" } %>
  #     <%= render Form::FieldGroupComponent.new do %>
  #       <!-- form fields here -->
  #     <% end %>
  #   <% end %>
  #
  # @param disabled [Boolean] Whether the fieldset is disabled
  # @param class [String] Additional CSS classes
  class FieldsetComponent < ApplicationComponent
    attr_reader :disabled, :options

    def initialize(disabled: false, **options)
      @disabled = disabled
      @options = options
    end

    def call
      tag.fieldset(content, disabled: disabled || nil, class: fieldset_classes, **options.except(:class))
    end

    private

    def fieldset_classes
      class_names(
        "*:data-[slot=text]:mt-1 [&>*+[data-slot=control]]:mt-6",
        options[:class]
      )
    end
  end
end
