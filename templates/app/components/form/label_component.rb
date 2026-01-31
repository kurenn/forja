# frozen_string_literal: true

module Form
  # Renders a form label element
  #
  # @example Basic label
  #   <%= render Form::LabelComponent.new(for: "email") { "Email address" } %>
  #
  # @param for [String] The ID of the form element this label is for
  # @param class [String] Additional CSS classes
  class LabelComponent < ApplicationComponent
    attr_reader :for_id, :options

    def initialize(for: nil, **options)
      @for_id = binding.local_variable_get(:for)
      @options = options
    end

    def call
      tag.label(content, for: for_id, data: { slot: "label" }, class: label_classes, **options.except(:class))
    end

    private

    def label_classes
      class_names(
        "text-base/6 text-olive-950 select-none sm:text-sm/6 dark:text-white",
        options[:class]
      )
    end
  end
end
