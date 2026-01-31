# frozen_string_literal: true

require "spec_helper"

RSpec.describe Forja::Validation do
  describe ".valid_app_name?" do
    it "accepts valid lowercase names" do
      expect(described_class.valid_app_name?("myapp")).to be true
      expect(described_class.valid_app_name?("my_app")).to be true
      expect(described_class.valid_app_name?("app123")).to be true
      expect(described_class.valid_app_name?("my_app_2")).to be true
    end

    it "rejects names starting with numbers" do
      expect(described_class.valid_app_name?("123app")).to be false
      expect(described_class.valid_app_name?("1_app")).to be false
    end

    it "rejects names starting with underscores" do
      expect(described_class.valid_app_name?("_myapp")).to be false
    end

    it "rejects names with uppercase letters" do
      expect(described_class.valid_app_name?("MyApp")).to be false
      expect(described_class.valid_app_name?("MYAPP")).to be false
    end

    it "rejects names with dashes" do
      expect(described_class.valid_app_name?("my-app")).to be false
    end

    it "rejects names with spaces" do
      expect(described_class.valid_app_name?("my app")).to be false
    end

    it "rejects empty or nil names" do
      expect(described_class.valid_app_name?(nil)).to be false
      expect(described_class.valid_app_name?("")).to be false
    end
  end

  describe ".validate_app_name!" do
    it "does not raise for valid names" do
      expect { described_class.validate_app_name!("valid_name") }.not_to raise_error
    end

    it "raises InvalidAppNameError for invalid names" do
      expect { described_class.validate_app_name!("Invalid") }.to raise_error(Forja::InvalidAppNameError)
      expect { described_class.validate_app_name!("123bad") }.to raise_error(Forja::InvalidAppNameError)
    end
  end

  describe ".normalize_path" do
    it "expands relative paths" do
      expect(described_class.normalize_path("./foo")).to eq(File.expand_path("./foo"))
    end

    it "expands home directory" do
      expect(described_class.normalize_path("~/foo")).to eq(File.expand_path("~/foo"))
    end
  end
end
