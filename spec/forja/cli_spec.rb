# frozen_string_literal: true

require "spec_helper"

RSpec.describe Forja::CLI do
  describe "help output" do
    it "includes banner text when run with no arguments" do
      output = capture_stdout { described_class.start([]) }
      expect(output).to include("Forja")
      expect(output).to include("Forge Rails apps, fast.")
    end

    it "includes Try tip" do
      output = capture_stdout { described_class.start([]) }
      stripped = output.gsub(/\e\[[0-9;]*m/, "")
      expect(stripped).to include('Try "forja new my_app"')
    end

    it "includes usage information" do
      output = capture_stdout { described_class.start([]) }
      expect(output).to include("forja new")
    end
  end

  describe "version command" do
    it "outputs the version" do
      output = capture_stdout { described_class.start(["version"]) }
      expect(output).to include(Forja::VERSION)
    end
  end

  def capture_stdout
    original = $stdout
    $stdout = StringIO.new
    yield
    $stdout.string
  ensure
    $stdout = original
  end
end
