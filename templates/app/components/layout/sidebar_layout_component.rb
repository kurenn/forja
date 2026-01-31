# frozen_string_literal: true

module Layout
  # Layout with fixed sidebar on desktop, collapsible on mobile
  #
  # @example Full layout
  #   <%= render Layout::SidebarLayoutComponent.new do |layout| %>
  #     <% layout.with_sidebar do %>
  #       <%= render Layout::SidebarComponent.new do %>
  #         <!-- Sidebar content -->
  #       <% end %>
  #     <% end %>
  #     <% layout.with_navbar do %>
  #       <%= render Layout::NavbarComponent.new do %>
  #         <!-- Mobile navbar content -->
  #       <% end %>
  #     <% end %>
  #     <!-- Main content -->
  #   <% end %>
  #
  # @param class [String] Additional CSS classes
  class SidebarLayoutComponent < ApplicationComponent
    renders_one :sidebar
    renders_one :navbar

    attr_reader :options

    def initialize(**options)
      @options = options
    end

    def call
      tag.div(
        data: { controller: "sidebar-layout" },
        class: container_classes
      ) do
        safe_join([
          desktop_sidebar,
          mobile_sidebar,
          mobile_header,
          main_content
        ])
      end
    end

    private

    def container_classes
      class_names(
        "relative isolate flex min-h-svh w-full bg-olive-50 max-lg:flex-col lg:bg-olive-100",
        "dark:bg-olive-900 lg:dark:bg-olive-950",
        options[:class]
      )
    end

    def desktop_sidebar
      tag.div(sidebar, class: "fixed inset-y-0 left-0 w-64 max-lg:hidden")
    end

    def mobile_sidebar
      tag.div(
        data: { sidebar_layout_target: "mobileSidebar" },
        class: "fixed inset-0 z-50 hidden lg:hidden"
      ) do
        safe_join([
          mobile_backdrop,
          mobile_panel
        ])
      end
    end

    def mobile_backdrop
      tag.div(
        "",
        data: { action: "click->sidebar-layout#close" },
        class: "fixed inset-0 bg-black/30 transition-opacity duration-300"
      )
    end

    def mobile_panel
      tag.div(
        class: "fixed inset-y-0 w-full max-w-80 p-2 transition-transform duration-300 -translate-x-full",
        data: { sidebar_layout_target: "panel" }
      ) do
        tag.div(class: panel_content_classes) do
          safe_join([
            close_button,
            sidebar
          ])
        end
      end
    end

    def panel_content_classes
      class_names(
        "flex h-full flex-col rounded-lg bg-white shadow-sm ring-1 ring-olive-950/5",
        "dark:bg-olive-900 dark:ring-white/10"
      )
    end

    def close_button
      tag.div(class: "-mb-3 px-4 pt-3") do
        tag.button(
          type: "button",
          class: close_button_classes,
          data: { action: "sidebar-layout#close" },
          "aria-label": "Close navigation"
        ) do
          close_icon
        end
      end
    end

    def close_button_classes
      class_names(
        "relative flex min-w-0 items-center gap-3 rounded-lg p-2 text-left text-base/6 font-medium text-olive-950 sm:text-sm/5",
        "*:data-[slot=icon]:size-6 *:data-[slot=icon]:shrink-0 *:data-[slot=icon]:fill-olive-500 sm:*:data-[slot=icon]:size-5",
        "hover:bg-olive-950/5 hover:*:data-[slot=icon]:fill-olive-950",
        "dark:text-white dark:*:data-[slot=icon]:fill-olive-400",
        "dark:hover:bg-white/5 dark:hover:*:data-[slot=icon]:fill-white"
      )
    end

    def close_icon
      tag.svg(
        viewBox: "0 0 20 20",
        "aria-hidden": "true",
        data: { slot: "icon" }
      ) do
        tag.path(
          d: "M6.28 5.22a.75.75 0 0 0-1.06 1.06L8.94 10l-3.72 3.72a.75.75 0 1 0 1.06 1.06L10 11.06l3.72 3.72a.75.75 0 1 0 1.06-1.06L11.06 10l3.72-3.72a.75.75 0 0 0-1.06-1.06L10 8.94 6.28 5.22Z",
          fill: "currentColor"
        )
      end
    end

    def mobile_header
      tag.header(class: "flex items-center px-4 lg:hidden") do
        safe_join([
          tag.div(class: "py-2.5") do
            open_menu_button
          end,
          tag.div(navbar, class: "min-w-0 flex-1")
        ])
      end
    end

    def open_menu_button
      tag.button(
        type: "button",
        class: close_button_classes,
        data: { action: "sidebar-layout#open" },
        "aria-label": "Open navigation"
      ) do
        menu_icon
      end
    end

    def menu_icon
      tag.svg(
        viewBox: "0 0 20 20",
        "aria-hidden": "true",
        data: { slot: "icon" }
      ) do
        tag.path(
          d: "M2 6.75C2 6.33579 2.33579 6 2.75 6H17.25C17.6642 6 18 6.33579 18 6.75C18 7.16421 17.6642 7.5 17.25 7.5H2.75C2.33579 7.5 2 7.16421 2 6.75ZM2 13.25C2 12.8358 2.33579 12.5 2.75 12.5H17.25C17.6642 12.5 18 12.8358 18 13.25C18 13.6642 17.6642 14 17.25 14H2.75C2.33579 14 2 13.6642 2 13.25Z",
          fill: "currentColor"
        )
      end
    end

    def main_content
      tag.main(class: main_classes) do
        tag.div(class: content_wrapper_classes) do
          content
        end
      end
    end

    def main_classes
      "flex flex-1 flex-col pb-2 lg:min-w-0 lg:pt-2 lg:pr-2 lg:pl-64"
    end

    def content_wrapper_classes
      class_names(
        "grow p-6 lg:rounded-lg lg:bg-white lg:p-10 lg:shadow-sm lg:ring-1 lg:ring-olive-200",
        "lg:dark:bg-olive-900 lg:dark:ring-olive-800"
      )
    end
  end
end
