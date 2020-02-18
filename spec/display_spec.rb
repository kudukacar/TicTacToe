require "spec_helper"
require "display"
require "fake_standard_out"

RSpec.describe Display do
  describe "#output" do
    it "prints a message" do
      stdout = FakeStandardOut.new
      display = Display.new(stdout)
      message = "hello"

      display.output(message)

      expect(stdout.log).to eq("hello")
    end
  end
end
