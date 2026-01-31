# frozen_string_literal: true

# Renders a user avatar with image or initials
#
# @example Avatar with image
#   <%= render AvatarComponent.new(src: user.avatar_url, alt: user.name) %>
#
# @example Avatar with initials
#   <%= render AvatarComponent.new(initials: "JD", alt: "John Doe") %>
#
# @example Square avatar
#   <%= render AvatarComponent.new(src: user.avatar_url, square: true) %>
#
# @example As interactive button
#   <%= render AvatarComponent.new(src: user.avatar_url, href: user_path(user)) %>
#
# @param src [String] Image URL
# @param initials [String] Initials to display when no image
# @param alt [String] Alt text for accessibility
# @param square [Boolean] Use square shape instead of circle. Default: false
# @param href [String] Optional link URL (makes avatar clickable)
# @param class [String] Additional CSS classes
class AvatarComponent < ApplicationComponent
  attr_reader :src, :initials, :alt, :square, :href, :options

  def initialize(src: nil, initials: nil, alt: "", square: false, href: nil, **options)
    @src = src
    @initials = initials
    @alt = alt
    @square = square
    @href = href
    @options = options
  end

  def call
    if href.present?
      render_as_link
    else
      render_avatar
    end
  end

  private

  def render_as_link
    link_to(href, class: link_classes, **options.except(:class)) do
      render_avatar
    end
  end

  def render_avatar
    tag.span(data: { slot: "avatar" }, class: avatar_classes) do
      safe_join([
        (render_initials if initials.present?),
        (render_image if src.present?)
      ].compact)
    end
  end

  def render_initials
    tag.svg(
      class: "size-full fill-current p-[5%] text-[48px] font-medium uppercase select-none",
      viewBox: "0 0 100 100",
      "aria-hidden": alt.blank? ? "true" : nil
    ) do
      safe_join([
        (tag.title(alt) if alt.present?),
        tag.text(
          initials,
          x: "50%",
          y: "50%",
          "alignment-baseline": "middle",
          "dominant-baseline": "middle",
          "text-anchor": "middle",
          dy: ".125em"
        )
      ].compact)
    end
  end

  def render_image
    tag.img(src: src, alt: alt, class: "size-full")
  end

  def avatar_classes
    class_names(
      "inline-grid shrink-0 align-middle [--avatar-radius:20%] *:col-start-1 *:row-start-1",
      "outline -outline-offset-1 outline-black/10 dark:outline-white/10",
      shape_classes,
      options[:class]
    )
  end

  def link_classes
    class_names(
      "relative inline-grid focus:outline-none focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-blue-500",
      square ? "rounded-[20%]" : "rounded-full"
    )
  end

  def shape_classes
    if square
      "rounded-[--avatar-radius] *:rounded-[--avatar-radius]"
    else
      "rounded-full *:rounded-full"
    end
  end
end
