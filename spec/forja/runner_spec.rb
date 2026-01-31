# frozen_string_literal: true

require "spec_helper"
require "tmpdir"

RSpec.describe Forja::Runner do
  let(:ui) { Forja::UI.new(color: false) }
  let(:tmpdir) { Dir.mktmpdir }
  let(:spec) { Forja::Spec.new(name: "test_app", path: tmpdir) }
  let(:runner) { described_class.new(spec: spec, ui: ui) }

  after do
    FileUtils.rm_rf(tmpdir)
  end

  describe "#run" do
    before do
      # Suppress output during tests
      allow($stdout).to receive(:puts)
      allow($stdout).to receive(:print)
    end

    it "creates the app directory" do
      runner.run
      expect(File.directory?(spec.full_path)).to be true
    end

    it "creates README.md" do
      runner.run
      readme_path = File.join(spec.full_path, "README.md")
      expect(File.exist?(readme_path)).to be true
      expect(File.read(readme_path)).to include("Test app")
      expect(File.read(readme_path)).to include("Forja")
    end

    it "creates Gemfile" do
      runner.run
      gemfile_path = File.join(spec.full_path, "Gemfile")
      expect(File.exist?(gemfile_path)).to be true
      expect(File.read(gemfile_path)).to include("rails")
    end

    it "creates .ruby-version" do
      runner.run
      ruby_version_path = File.join(spec.full_path, ".ruby-version")
      expect(File.exist?(ruby_version_path)).to be true
      expect(File.read(ruby_version_path).strip).to eq("3.2.0")
    end

    it "creates forja.json with spec data" do
      runner.run
      forja_json_path = File.join(spec.full_path, "forja.json")
      expect(File.exist?(forja_json_path)).to be true

      data = JSON.parse(File.read(forja_json_path))
      expect(data["name"]).to eq("test_app")
    end

    context "when directory already exists" do
      before do
        FileUtils.mkdir_p(spec.full_path)
      end

      it "prompts for confirmation" do
        allow_any_instance_of(TTY::Prompt).to receive(:yes?).and_return(true)
        expect { runner.run }.not_to raise_error
      end

      it "raises error if user declines" do
        allow_any_instance_of(TTY::Prompt).to receive(:yes?).and_return(false)
        expect { runner.run }.to raise_error(Forja::DirectoryExistsError)
      end
    end
  end
end
