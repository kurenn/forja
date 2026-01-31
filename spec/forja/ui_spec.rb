# frozen_string_literal: true

require "spec_helper"

RSpec.describe Forja::UI do
  let(:ui) { described_class.new(color: false) }

  describe "#banner" do
    it "includes the version" do
      expect(ui.banner).to include("Forja")
      expect(ui.banner).to include(Forja::VERSION)
    end

    it "includes the tagline" do
      expect(ui.banner).to include("Forge Rails apps, fast.")
    end

    it "includes the Try tip" do
      expect(ui.banner).to include('Try "forja new my_app"')
    end

    it "includes the mascot" do
      expect(ui.banner).to include("⚒")
    end
  end

  describe "#usage" do
    it "includes usage information" do
      expect(ui.usage).to include("forja new")
      expect(ui.usage).to include("--path")
    end
  end

  describe "#random_loading_phrase" do
    it "returns one of the loading phrases" do
      phrase = ui.random_loading_phrase
      expect(Forja::UI::LOADING_PHRASES).to include(phrase)
    end
  end

  describe "#random_tip" do
    it "returns one of the tips" do
      tip = ui.random_tip
      expect(Forja::UI::TIPS).to include(tip)
    end
  end

  describe "#summary" do
    let(:spec) { Forja::Spec.new(name: "test_app", path: "/tmp") }

    it "includes the app name" do
      expect(ui.summary(spec)).to include("test_app")
    end

    it "includes the full path" do
      expect(ui.summary(spec)).to include("/tmp/test_app")
    end

    it "includes success message" do
      expect(ui.summary(spec)).to include("forged successfully")
    end
  end

  describe "color support" do
    it "respects color: false" do
      ui = described_class.new(color: false)
      expect(ui.color_enabled).to be false
    end

    it "respects NO_COLOR env var" do
      allow(ENV).to receive(:key?).with("NO_COLOR").and_return(true)
      ui = described_class.new(color: true)
      expect(ui.color_enabled).to be false
    end
  end
end
