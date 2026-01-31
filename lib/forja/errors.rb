# frozen_string_literal: true

module Forja
  class Error < StandardError; end

  class ValidationError < Error; end

  class InvalidAppNameError < ValidationError
    def initialize(name)
      super("Invalid app name '#{name}'. Must start with a letter and contain only lowercase letters, numbers, and underscores.")
    end
  end

  class DirectoryExistsError < Error
    def initialize(path)
      super("Directory already exists: #{path}")
    end
  end

  class PathNotWritableError < Error
    def initialize(path)
      super("Cannot write to path: #{path}")
    end
  end

  class RailsNotFoundError < Error
    def initialize
      super("Rails is not installed. Please install Rails with: gem install rails")
    end
  end

  class RailsVersionError < Error
    def initialize(current_version, required_version)
      super("Rails version #{current_version} is installed, but Forja requires Rails #{required_version} or higher. Please upgrade with: gem update rails")
    end
  end

  class RailsGenerationError < Error; end
end
