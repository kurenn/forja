# frozen_string_literal: true

require "spec_helper"

RSpec.describe Forja::Spec do
  let(:spec) { described_class.new(name: "my_app", path: "/tmp") }

  describe "#initialize" do
    it "sets name and path" do
      expect(spec.name).to eq("my_app")
      expect(spec.path).to eq("/tmp")
    end

    it "normalizes the path" do
      spec = described_class.new(name: "app", path: "./relative")
      expect(spec.path).to eq(File.expand_path("./relative"))
    end

    it "sets created_at" do
      expect(spec.created_at).to be_a(Time)
    end

    it "is frozen" do
      expect(spec).to be_frozen
    end
  end

  describe "#full_path" do
    it "joins path and name" do
      expect(spec.full_path).to eq("/tmp/my_app")
    end
  end

  describe "#to_h" do
    it "returns a hash representation" do
      hash = spec.to_h
      expect(hash[:name]).to eq("my_app")
      expect(hash[:path]).to eq("/tmp")
      expect(hash[:full_path]).to eq("/tmp/my_app")
      expect(hash[:created_at]).to be_a(String)
    end
  end

  describe "#to_json" do
    it "returns valid JSON" do
      json = spec.to_json
      parsed = JSON.parse(json)
      expect(parsed["name"]).to eq("my_app")
    end
  end
end
