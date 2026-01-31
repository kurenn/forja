# frozen_string_literal: true

require "json"
require "time"

module Forja
  class Spec
    attr_reader :name, :path, :created_at

    def initialize(name:, path:, created_at: Time.now)
      @name = name.freeze
      @path = Validation.normalize_path(path).freeze
      @created_at = created_at.freeze
      freeze
    end

    def full_path
      File.join(path, name)
    end

    def to_h
      {
        name: name,
        path: path,
        full_path: full_path,
        created_at: created_at.iso8601
      }
    end

    def to_json(*args)
      to_h.to_json(*args)
    end
  end
end
