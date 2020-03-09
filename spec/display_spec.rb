require "spec_helper"
require "game"

RSpec.describe Display do
  subject(:display) { Display.new(stdout, stdin) }
  let(:stdout) { FakeStandardOut.new }
  let(:stdin) { FakeStandardIn.new(["5"]) }

  class FakeStandardOut
    attr_reader :messages

    def initialize
      @messages = []
    end

    def puts(message)
      @messages << message
      nil
    end
  end

  class FakeStandardIn
    def initialize(inputs)
      @inputs = inputs
    end

    def gets
      @inputs.shift
    end
  end

  describe "#output" do
    it "prints a message" do
      message = "Welcome to Tic-Tac-Toe"

      display.output(message)

      expect(stdout.messages).to eq(["Welcome to Tic-Tac-Toe"])
    end
  end

  describe "#input" do
    it "gets the player's input" do
      expect(display.input).to eq("5")
    end
  end
end
