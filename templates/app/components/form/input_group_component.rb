# frozen_string_literal: true

module Form
  # Wraps an input with optional leading/trailing icons
  #
  # @example Input with leading icon
  #   <%= render Form::InputGroupComponent.new do %>
  #     <svg data-slot="icon" class="size-5">...</svg>
  #     <%= render Form::InputComponent.new(name: "search") %>
  #   <% end %>
  #
  # @param class [String] Additional CSS classes
  class InputGroupComponent < ApplicationComponent
    attr_reader :options

    def initialize(**options)
      @options = options
    end

    def call
      tag.span(content, data: { slot: "control" }, class: group_classes, **options.except(:class))
    end

    private

    def group_classes
      class_names(
        "relative isolate block",
        # Input padding when icons present
        "has-[[data-slot=icon]:first-child]:[&_input]:pl-10 has-[[data-slot=icon]:last-child]:[&_input]:pr-10 sm:has-[[data-slot=icon]:first-child]:[&_input]:pl-8 sm:has-[[data-slot=icon]:last-child]:[&_input]:pr-8",
        # Icon positioning
        "*:data-[slot=icon]:pointer-events-none *:data-[slot=icon]:absolute *:data-[slot=icon]:top-3 *:data-[slot=icon]:z-10 *:data-[slot=icon]:size-5 sm:*:data-[slot=icon]:top-2.5 sm:*:data-[slot=icon]:size-4",
        "[&>[data-slot=icon]:first-child]:left-3 sm:[&>[data-slot=icon]:first-child]:left-2.5 [&>[data-slot=icon]:last-child]:right-3 sm:[&>[data-slot=icon]:last-child]:right-2.5",
        # Icon colors
        "*:data-[slot=icon]:text-olive-500 dark:*:data-[slot=icon]:text-olive-400",
        options[:class]
      )
    end
  end
end
