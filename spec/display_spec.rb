require "spec_helper"
require "tictactoe"

RSpec.describe Display do
  class FakeStandardOut
    attr_reader :log
  
    def initialize
      @log = ""
    end
  
    def puts(message)
      @log += message
      nil
    end
  end
  
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
