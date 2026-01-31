# frozen_string_literal: true

# Keyboard shortcut display within a dropdown item
#
# @example Single key
#   <%= render DropdownShortcutComponent.new(keys: "E") %>
#
# @example Multiple keys
#   <%= render DropdownShortcutComponent.new(keys: ["⌘", "S"]) %>
#
# @param keys [String, Array<String>] Keyboard keys to display
# @param class [String] Additional CSS classes
class DropdownShortcutComponent < ApplicationComponent
  attr_reader :keys, :options

  def initialize(keys:, **options)
    @keys = keys.is_a?(Array) ? keys : keys.to_s.chars
    @options = options
  end

  def call
    tag.kbd(class: shortcut_classes, **options.except(:class)) do
      safe_join(keys.each_with_index.map { |key, index| render_key(key, index) })
    end
  end

  private

  def shortcut_classes
    class_names(
      "col-start-5 row-start-1 flex justify-self-end",
      options[:class]
    )
  end

  def render_key(key, index)
    tag.kbd(key, class: key_classes(key, index))
  end

  def key_classes(key, index)
    class_names(
      "min-w-[2ch] text-center font-sans capitalize",
      "text-olive-400 group-focus:text-white group-hover:text-white",
      "forced-colors:group-focus:text-[HighlightText]",
      # Extra padding for multi-character keys after the first
      index > 0 && key.length > 1 ? "pl-1" : nil
    )
  end
end
