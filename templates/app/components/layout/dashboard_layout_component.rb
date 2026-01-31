# frozen_string_literal: true

module Layout
  # Dashboard layout with sidebar navigation
  #
  # @example
  #   <%= render Layout::DashboardLayoutComponent.new do %>
  #     <!-- Page content -->
  #   <% end %>
  class DashboardLayoutComponent < ApplicationComponent
    NAVIGATION = [
      { name: 'Home', path: 'authenticated_root_path', icon: 'home' },
      { name: 'Users', path: 'authenticated_root_path', icon: 'users' }
    ].freeze

    attr_reader :controller

    def initialize(controller: nil)
      @controller = controller
    end

    def call
      render Layout::SidebarLayoutComponent.new do |layout|
        layout.with_sidebar do
          render_sidebar
        end
        content
      end
    end

    private

    def render_sidebar
      render Layout::SidebarComponent.new(class: 'bg-olive-50 dark:bg-olive-950 text-olive-900 dark:text-olive-100 border-r border-olive-200 dark:border-olive-800') do
        safe_join([
                    render_sidebar_header,
                    render_sidebar_body,
                    render_sidebar_footer
                  ])
      end
    end

    def render_sidebar_header
      render Layout::SidebarHeaderComponent.new do
        tag.div(helpers.current_user.email, class: 'text-lg font-semibold text-olive-900 dark:text-olive-100')
      end
    end

    def render_sidebar_body
      render Layout::SidebarBodyComponent.new do
        NAVIGATION.map { |nav| render_nav_item(nav) }.join.html_safe
      end
    end

    def render_nav_item(nav)
      path = Rails.application.routes.url_helpers.public_send(nav[:path])
      render Layout::SidebarItemComponent.new(
        href: path,
        current: current_page_path?(path),
        class: nav_item_classes
      ) do
        safe_join([
                    render_nav_icon(nav[:icon]),
                    tag.span(nav[:name])
                  ])
      end
    end

    def current_page_path?(path)
      helpers.request.path == path
    end

    def nav_item_classes
      class_names(
        'text-olive-600 hover:bg-olive-200 hover:text-olive-900',
        'dark:text-olive-300 dark:hover:bg-olive-800 dark:hover:text-olive-100'
      )
    end

    def render_nav_icon(icon_name)
      case icon_name
      when 'home'
        render_home_icon
      when 'users'
        render_users_icon
      when 'key'
        render_key_icon
      when 'wallet'
        render_wallet_icon
      end
    end

    def render_home_icon
      tag.svg(
        viewBox: '0 0 20 20',
        "aria-hidden": 'true',
        data: { slot: 'icon' }
      ) do
        tag.path(
          d: 'M10.5 1.581a.75.75 0 0 0-1 0l-7 5.75a.75.75 0 0 0-.25.534v9.635a.75.75 0 0 0 .75.75h4.5a.75.75 0 0 0 .75-.75v-4.5h2a.75.75 0 0 1 .75.75v4.5a.75.75 0 0 0 .75.75h4.5a.75.75 0 0 0 .75-.75V7.865a.75.75 0 0 0-.25-.534l-7-5.75Z',
          fill: 'currentColor'
        )
      end
    end

    def render_users_icon
      tag.svg(
        viewBox: '0 0 20 20',
        "aria-hidden": 'true',
        data: { slot: 'icon' }
      ) do
        tag.path(
          d: 'M10 9a3 3 0 1 0 0-6 3 3 0 0 0 0 6ZM-2 17c0-1 2-3 12-3s12 2 12 3v1H-2v-1Z',
          fill: 'currentColor'
        )
      end
    end

    def render_key_icon
      tag.svg(
        viewBox: '0 0 20 20',
        "aria-hidden": 'true',
        data: { slot: 'icon' }
      ) do
        tag.path(
          d: 'M3.613 3.613a.75.75 0 0 0 0 1.06L5.81 6.883a.5.5 0 0 1 0 .707L3.613 9.787a.75.75 0 1 0 1.06 1.06l2.197-2.196a.75.75 0 0 0 0-1.06L4.673 4.673a.75.75 0 0 0-1.06 0Z',
          fill: 'currentColor'
        )
      end
    end

    def render_wallet_icon
      tag.svg(
        viewBox: '0 0 20 20',
        "aria-hidden": 'true',
        data: { slot: 'icon' }
      ) do
        tag.path(
          d: 'M4 4a2 2 0 0 0-2 2v4a2 2 0 0 0 2 2V6h10a2 2 0 1 1 0 4H4v4a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V6a2 2 0 0 0-2-2H4Z',
          fill: 'currentColor'
        )
      end
    end

    def render_sidebar_footer
      render Layout::SidebarFooterComponent.new do
        safe_join([
                    render_dark_mode_toggle,
                    render_logout_item
                  ])
      end
    end

    def render_logout_item
      render(Layout::SidebarItemComponent.new(href: destroy_user_session_path, data: { turbo_method: :delete })) do
        safe_join([
                    render_logout_icon,
                    tag.span('Sign out')
                  ])
      end
    end

    def render_dark_mode_toggle
      tag.div(data: { controller: 'dark-mode' }) do
        tag.button(
          type: 'button',
          class: dark_mode_toggle_classes,
          data: { action: 'click->dark-mode#toggle' }
        ) do
          safe_join([
                      tag.svg(
                        viewBox: '0 0 20 20',
                        class: 'size-4 shrink-0 fill-current',
                        "aria-hidden": 'true',
                        data: { "dark-mode-target": 'icon' }
                      ) do
                        # Default moon icon (will be updated by JS)
                        tag.path(
                          "fill-rule": 'evenodd',
                          d: 'M7.455 2.004a.75.75 0 0 1 .26.77 7 7 0 0 0 9.958 7.967.75.75 0 0 1 1.067.853A8.5 8.5 0 1 1 6.647 1.921a.75.75 0 0 1 .808.083Z',
                          "clip-rule": 'evenodd',
                          fill: 'currentColor'
                        )
                      end,
                      tag.span('Toggle theme')
                    ])
        end
      end
    end

    def dark_mode_toggle_classes
      class_names(
        'flex w-full items-center gap-2 rounded-lg px-2 py-1.5 text-left text-sm font-medium',
        'text-olive-600 hover:bg-olive-200 hover:text-olive-900',
        'dark:text-olive-400 dark:hover:bg-olive-800 dark:hover:text-olive-100'
      )
    end

    def render_logout_icon
      tag.svg(
        viewBox: '0 0 20 20',
        class: 'size-4 shrink-0 fill-olive-500 dark:fill-olive-400',
        "aria-hidden": 'true',
        data: { slot: 'icon' }
      ) do
        tag.path(
          "fill-rule": 'evenodd',
          d: 'M3 4.25A2.25 2.25 0 0 1 5.25 2h5.5A2.25 2.25 0 0 1 13 4.25v2a.75.75 0 0 1-1.5 0v-2a.75.75 0 0 0-.75-.75h-5.5a.75.75 0 0 0-.75.75v11.5c0 .414.336.75.75.75h5.5a.75.75 0 0 0 .75-.75v-2a.75.75 0 0 1 1.5 0v2A2.25 2.25 0 0 1 10.75 18h-5.5A2.25 2.25 0 0 1 3 15.75V4.25Z',
          "clip-rule": 'evenodd',
          fill: 'currentColor'
        )
        tag.path(
          "fill-rule": 'evenodd',
          d: 'M19 10a.75.75 0 0 0-.75-.75H8.704l1.048-.943a.75.75 0 1 0-1.004-1.114l-2.5 2.25a.75.75 0 0 0 0 1.114l2.5 2.25a.75.75 0 1 0 1.004-1.114l-1.048-.943h9.546A.75.75 0 0 0 19 10Z',
          "clip-rule": 'evenodd',
          fill: 'currentColor'
        )
      end
    end
  end
end
