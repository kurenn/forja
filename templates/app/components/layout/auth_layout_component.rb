# frozen_string_literal: true

module Layout
  # Centered authentication layout for login/register pages
  #
  # @example Login page
  #   <%= render Layout::AuthLayoutComponent.new do %>
  #     <div class="w-full max-w-sm">
  #       <h1>Sign in</h1>
  #       <!-- Login form -->
  #     </div>
  #   <% end %>
  #
  # @param class [String] Additional CSS classes
  class AuthLayoutComponent < ApplicationComponent
    attr_reader :options

    def initialize(**options)
      @options = options
    end

    def call
      tag.main(class: main_classes) do
        tag.div(content, class: content_classes)
      end
    end

    private

    def main_classes
      class_names(
        "flex min-h-dvh flex-col p-2",
        options[:class]
      )
    end

    def content_classes
      class_names(
        "flex grow items-center justify-center p-6",
        "lg:rounded-lg lg:bg-white lg:p-10 lg:shadow-sm lg:ring-1 lg:ring-olive-950/5",
        "dark:lg:bg-olive-900 dark:lg:ring-white/10"
      )
    end
  end
end
