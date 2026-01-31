# frozen_string_literal: true

# Renders styled anchor links
#
# @example Basic link
#   <%= render LinkComponent.new(href: "/about") { "About Us" } %>
#
# @example External link
#   <%= render LinkComponent.new(href: "https://example.com", target: "_blank") { "External" } %>
#
# @example Text link style (underlined)
#   <%= render LinkComponent.new(href: "/docs", variant: :text) { "Documentation" } %>
#
# @param href [String] Link destination URL
# @param variant [Symbol] Link style (:default, :text). Default: :default
# @param class [String] Additional CSS classes
class LinkComponent < ApplicationComponent
  VARIANTS = {
    default: "",
    text: "text-olive-950 underline decoration-olive-950/50 hover:decoration-olive-950 dark:text-white dark:decoration-white/50 dark:hover:decoration-white"
  }.freeze

  attr_reader :href, :variant, :options

  def initialize(href:, variant: :default, **options)
    @href = href
    @variant = variant
    @options = options
  end

  def call
    link_to(content, href, class: classes, **options.except(:class))
  end

  private

  def classes
    class_names(
      variant_classes(VARIANTS, variant, :default),
      options[:class]
    )
  end
end
