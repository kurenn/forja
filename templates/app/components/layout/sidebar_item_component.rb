# frozen_string_literal: true

module Layout
  # Individual navigation item in sidebar
  #
  # @example Link item
  #   <%= render Layout::SidebarItemComponent.new(href: "/dashboard") do %>
  #     <svg data-slot="icon">...</svg>
  #     Dashboard
  #   <% end %>
  #
  # @example Current item
  #   <%= render Layout::SidebarItemComponent.new(href: "/dashboard", current: true) do %>
  #     Dashboard
  #   <% end %>
  #
  # @param href [String] Link URL (renders as link if provided)
  # @param current [Boolean] Whether this is the current/active item
  # @param class [String] Additional CSS classes
  class SidebarItemComponent < ApplicationComponent
    attr_reader :href, :current, :options

    def initialize(href: nil, current: false, **options)
      @href = href
      @current = current
      @options = options
    end

    def call
      tag.span(class: wrapper_classes) do
        safe_join([
          current_indicator,
          item_element
        ])
      end
    end

    private

    def wrapper_classes
      class_names("relative", options[:class])
    end

    def current_indicator
      return "" unless current

      tag.span(
        "",
        class: "absolute inset-y-2 -left-4 w-0.5 rounded-full bg-olive-950 dark:bg-white"
      )
    end

    def item_element
      if href.present?
        link_to(href, class: item_classes, data: current_data, **options.except(:class)) do
          content
        end
      else
        tag.button(type: "button", class: button_classes, data: current_data) do
          content
        end
      end
    end

    def touch_target(&block)
      tag.span(class: "absolute left-1/2 top-1/2 size-[max(100%,2.75rem)] -translate-x-1/2 -translate-y-1/2 [@media(pointer:fine)]:hidden", "aria-hidden": "true")
      content_tag(:span, capture(&block))
    end

    def current_data
      current ? { current: "true" } : {}
    end

    def item_classes
      class_names(base_classes)
    end

    def button_classes
      class_names("cursor-default", base_classes)
    end

    def base_classes
      class_names(
        # Base
        "flex w-full items-center gap-2 rounded-lg px-2 py-1.5 text-left text-sm font-medium text-olive-700 sm:py-1.5 sm:text-sm",
        # Leading icon
        "*:data-[slot=icon]:size-4 *:data-[slot=icon]:shrink-0 *:data-[slot=icon]:fill-olive-500 sm:*:data-[slot=icon]:size-4",
        # Trailing icon
        "*:last:data-[slot=icon]:ml-auto *:last:data-[slot=icon]:size-4 sm:*:last:data-[slot=icon]:size-4",
        # Avatar
        "*:data-[slot=avatar]:-m-0.5 *:data-[slot=avatar]:size-5 sm:*:data-[slot=avatar]:size-5",
        # Hover (light mode)
        "hover:bg-olive-200 hover:text-olive-900 hover:*:data-[slot=icon]:fill-olive-700",
        # Active (light mode)
        "active:bg-olive-200 active:*:data-[slot=icon]:fill-olive-700",
        # Current (light mode)
        "data-[current]:text-olive-900 data-[current]:*:data-[slot=icon]:fill-olive-700",
        # Dark mode
        "dark:text-olive-300 dark:*:data-[slot=icon]:fill-olive-400",
        "dark:hover:bg-olive-800 dark:hover:text-olive-100 dark:hover:*:data-[slot=icon]:fill-olive-100",
        "dark:active:bg-olive-800 dark:active:*:data-[slot=icon]:fill-olive-100",
        "dark:data-[current]:text-olive-100 dark:data-[current]:*:data-[slot=icon]:fill-olive-100"
      )
    end
  end
end
