# frozen_string_literal: true

# Base class for all ViewComponents in the application.
# Provides common utilities for consistent component development.
#
# @example Inheriting from ApplicationComponent
#   class ButtonComponent < ApplicationComponent
#     def initialize(variant: :primary)
#       @variant = variant
#     end
#   end
class ApplicationComponent < ViewComponent::Base
  # Common size options used across components
  SIZES = %i[xs sm md lg xl].freeze

  private

  # Joins CSS class names, filtering out nil and blank values
  #
  # @param classes [Array<String, nil>] CSS class names to join
  # @return [String] Space-separated class names
  #
  # @example
  #   class_names("btn", nil, "btn-primary", "")
  #   # => "btn btn-primary"
  def class_names(*classes)
    classes.flatten.compact.reject(&:blank?).join(" ")
  end

  # Returns classes based on a condition
  #
  # @param condition [Boolean] The condition to evaluate
  # @param true_classes [String] Classes to return if condition is true
  # @param false_classes [String] Classes to return if condition is false
  # @return [String] The appropriate classes
  #
  # @example
  #   classes_if(active?, "bg-olive-600", "bg-olive-100")
  def classes_if(condition, true_classes, false_classes = "")
    condition ? true_classes : false_classes
  end

  # Fetches variant classes from a hash with a fallback default
  #
  # @param variants [Hash] Hash mapping variant keys to class strings
  # @param key [Symbol] The variant key to look up
  # @param default [Symbol] The fallback key if key is not found
  # @return [String] The variant classes
  #
  # @example
  #   variant_classes(VARIANTS, @variant, :primary)
  def variant_classes(variants, key, default = nil)
    variants[key] || variants[default] || ""
  end
end
