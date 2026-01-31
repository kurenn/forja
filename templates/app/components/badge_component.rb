# frozen_string_literal: true

# Renders a colored badge/tag
#
# @example Basic badge
#   <%= render BadgeComponent.new { "Active" } %>
#
# @example Colored badge
#   <%= render BadgeComponent.new(color: :green) { "Success" } %>
#
# @example As interactive button
#   <%= render BadgeComponent.new(href: "/filter/active", color: :blue) { "Active" } %>
#
# @param color [Symbol] Badge color. Default: :olive
# @param href [String] Optional link URL (makes badge interactive)
# @param class [String] Additional CSS classes
class BadgeComponent < ApplicationComponent
  COLORS = {
    olive: "bg-olive-600/10 text-olive-700 hover:bg-olive-600/20 dark:bg-white/5 dark:text-olive-400 dark:hover:bg-white/10",
    red: "bg-red-500/15 text-red-700 hover:bg-red-500/25 dark:bg-red-500/10 dark:text-red-400 dark:hover:bg-red-500/20",
    orange: "bg-orange-500/15 text-orange-700 hover:bg-orange-500/25 dark:bg-orange-500/10 dark:text-orange-400 dark:hover:bg-orange-500/20",
    amber: "bg-amber-400/20 text-amber-700 hover:bg-amber-400/30 dark:bg-amber-400/10 dark:text-amber-400 dark:hover:bg-amber-400/15",
    yellow: "bg-yellow-400/20 text-yellow-700 hover:bg-yellow-400/30 dark:bg-yellow-400/10 dark:text-yellow-300 dark:hover:bg-yellow-400/15",
    lime: "bg-lime-400/20 text-lime-700 hover:bg-lime-400/30 dark:bg-lime-400/10 dark:text-lime-300 dark:hover:bg-lime-400/15",
    green: "bg-green-500/15 text-green-700 hover:bg-green-500/25 dark:bg-green-500/10 dark:text-green-400 dark:hover:bg-green-500/20",
    emerald: "bg-emerald-500/15 text-emerald-700 hover:bg-emerald-500/25 dark:bg-emerald-500/10 dark:text-emerald-400 dark:hover:bg-emerald-500/20",
    teal: "bg-teal-500/15 text-teal-700 hover:bg-teal-500/25 dark:bg-teal-500/10 dark:text-teal-300 dark:hover:bg-teal-500/20",
    cyan: "bg-cyan-400/20 text-cyan-700 hover:bg-cyan-400/30 dark:bg-cyan-400/10 dark:text-cyan-300 dark:hover:bg-cyan-400/15",
    sky: "bg-sky-500/15 text-sky-700 hover:bg-sky-500/25 dark:bg-sky-500/10 dark:text-sky-300 dark:hover:bg-sky-500/20",
    blue: "bg-blue-500/15 text-blue-700 hover:bg-blue-500/25 dark:text-blue-400 dark:hover:bg-blue-500/25",
    indigo: "bg-indigo-500/15 text-indigo-700 hover:bg-indigo-500/25 dark:text-indigo-400 dark:hover:bg-indigo-500/20",
    violet: "bg-violet-500/15 text-violet-700 hover:bg-violet-500/25 dark:text-violet-400 dark:hover:bg-violet-500/20",
    purple: "bg-purple-500/15 text-purple-700 hover:bg-purple-500/25 dark:text-purple-400 dark:hover:bg-purple-500/20",
    fuchsia: "bg-fuchsia-400/15 text-fuchsia-700 hover:bg-fuchsia-400/25 dark:bg-fuchsia-400/10 dark:text-fuchsia-400 dark:hover:bg-fuchsia-400/20",
    pink: "bg-pink-400/15 text-pink-700 hover:bg-pink-400/25 dark:bg-pink-400/10 dark:text-pink-400 dark:hover:bg-pink-400/20",
    rose: "bg-rose-400/15 text-rose-700 hover:bg-rose-400/25 dark:bg-rose-400/10 dark:text-rose-400 dark:hover:bg-rose-400/20"
  }.freeze

  attr_reader :color, :href, :options

  def initialize(color: :olive, href: nil, **options)
    @color = color
    @href = href
    @options = options
  end

  def call
    if href.present?
      render_as_link
    else
      render_as_span
    end
  end

  private

  def render_as_span
    tag.span(content, class: badge_classes, **options.except(:class))
  end

  def render_as_link
    link_to(href, class: link_classes, **options.except(:class)) do
      tag.span(content, class: badge_classes)
    end
  end

  def badge_classes
    class_names(
      "inline-flex items-center gap-x-1.5 rounded-md px-1.5 py-0.5",
      "text-sm/5 font-medium sm:text-xs/5",
      "forced-colors:outline",
      color_classes,
      options[:class]
    )
  end

  def link_classes
    "group relative inline-flex rounded-md focus:outline-none focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-blue-500"
  end

  def color_classes
    variant_classes(COLORS, color, :olive)
  end
end
