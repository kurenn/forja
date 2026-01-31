# frozen_string_literal: true

require "spec_helper"

RSpec.describe Forja::Wizard do
  let(:ui) { Forja::UI.new(color: false) }
  let(:wizard) { described_class.new(ui: ui) }

  describe "#run" do
    context "when app_name and path are provided" do
      it "returns a Spec with those values" do
        spec = wizard.run(app_name: "my_app", path: "/tmp")

        expect(spec).to be_a(Forja::Spec)
        expect(spec.name).to eq("my_app")
        expect(spec.path).to eq("/tmp")
      end
    end

    context "when only app_name is provided" do
      it "returns a Spec with app_name set" do
        allow_any_instance_of(TTY::Prompt).to receive(:ask).and_return("/custom/path")

        spec = wizard.run(app_name: "provided_app", path: nil)

        expect(spec.name).to eq("provided_app")
      end
    end

    context "when only path is provided" do
      it "returns a Spec with path set" do
        allow_any_instance_of(TTY::Prompt).to receive(:ask).and_return("prompted_app")

        spec = wizard.run(app_name: nil, path: "/provided/path")

        expect(spec.path).to eq("/provided/path")
      end
    end
  end
end
