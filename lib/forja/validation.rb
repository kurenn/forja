# frozen_string_literal: true

module Forja
  module Validation
    APP_NAME_PATTERN = /\A[a-z][a-z0-9_]*\z/

    class << self
      def valid_app_name?(name)
        return false if name.nil? || name.empty?

        APP_NAME_PATTERN.match?(name)
      end

      def validate_app_name!(name)
        return if valid_app_name?(name)

        raise InvalidAppNameError, name
      end

      def normalize_path(path)
        File.expand_path(path)
      end

      def path_writable?(path)
        dir = File.dirname(normalize_path(path))
        File.writable?(dir) || (File.exist?(dir) == false && path_writable?(dir))
      rescue SystemCallError
        false
      end

      def directory_exists?(path)
        File.directory?(normalize_path(path))
      end

      def rails_installed?
        Bundler.with_unbundled_env do
          system('rails --version > /dev/null 2>&1')
        end
      end

      def rails_version
        return nil unless rails_installed?
        
        version_output = Bundler.with_unbundled_env do
          `rails --version 2>&1`.strip
        end
        
        match = version_output.match(/Rails (\d+\.\d+\.\d+)/)
        match ? match[1] : nil
      end

      def check_rails_version!(required_version = '8.0.0')
        unless rails_installed?
          raise RailsNotFoundError
        end

        current = rails_version
        return unless current

        if Gem::Version.new(current) < Gem::Version.new(required_version)
          raise RailsVersionError.new(current, required_version)
        end
      end
    end
  end
end
