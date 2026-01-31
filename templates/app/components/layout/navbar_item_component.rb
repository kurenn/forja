# frozen_string_literal: true

module Layout
  # Individual navigation item in navbar
  #
  # @example Link item
  #   <%= render Layout::NavbarItemComponent.new(href: "/dashboard") do %>
  #     Dashboard
  #   <% end %>
  #
  # @example Current item
  #   <%= render Layout::NavbarItemComponent.new(href: "/dashboard", current: true) do %>
  #     Dashboard
  #   <% end %>
  #
  # @param href [String] Link URL (renders as link if provided)
  # @param current [Boolean] Whether this is the current/active item
  # @param class [String] Additional CSS classes
  class NavbarItemComponent < ApplicationComponent
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
        class: "absolute inset-x-2 -bottom-2.5 h-0.5 rounded-full bg-olive-950 dark:bg-white"
      )
    end

    def item_element
      if href.present?
        link_to(href, class: item_classes, data: current_data) do
          touch_target { content }
        end
      else
        tag.button(type: "button", class: button_classes, data: current_data, **button_options) do
          touch_target { content }
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

    def button_options
      options.slice(:onclick, :aria, :"aria-label")
    end

    def item_classes
      base_classes
    end

    def button_classes
      class_names("cursor-default", base_classes)
    end

    def base_classes
      class_names(
        # Base
        "relative flex min-w-0 items-center gap-3 rounded-lg p-2 text-left text-base/6 font-medium text-olive-950 sm:text-sm/5",
        # Leading icon
        "*:data-[slot=icon]:size-6 *:data-[slot=icon]:shrink-0 *:data-[slot=icon]:fill-olive-500 sm:*:data-[slot=icon]:size-5",
        # Trailing icon
        "*:not-nth-2:last:data-[slot=icon]:ml-auto *:not-nth-2:last:data-[slot=icon]:size-5 sm:*:not-nth-2:last:data-[slot=icon]:size-4",
        # Avatar
        "*:data-[slot=avatar]:-m-0.5 *:data-[slot=avatar]:size-7 sm:*:data-[slot=avatar]:size-6",
        # Hover
        "hover:bg-olive-950/5 hover:*:data-[slot=icon]:fill-olive-950",
        # Active
        "active:bg-olive-950/5 active:*:data-[slot=icon]:fill-olive-950",
        # Dark mode
        "dark:text-white dark:*:data-[slot=icon]:fill-olive-400",
        "dark:hover:bg-white/5 dark:hover:*:data-[slot=icon]:fill-white",
        "dark:active:bg-white/5 dark:active:*:data-[slot=icon]:fill-white"
      )
    end
  end
end
