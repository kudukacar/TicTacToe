require "spec_helper"
require "tictactoe"

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

  describe "#prompt" do
    class PlusTenAgeParser
      def call(input)
        input.to_i + 10
      end
    end

    it "ask the user for input" do
      display.prompt("How old are you?")

      expect(stdout.messages).to include("How old are you?")
    end

    it "will return the users input" do
      expect(display.prompt("Age?")).to eq("5")
    end

    context "with a parser" do
      it "will parse the input" do
        parsed_input = display.prompt("Age?", parse: PlusTenAgeParser.new)
        
        expect(parsed_input).to eq(15)
      end
    end

    context "with a validator" do
      class MustBeThree
        def errors_for(input)
          "#{input} is not Three" if input != "3"
        end
      end

      it "will validate the input" do
        validated_input = Display.new(stdout, FakeStandardIn.new(["-1", "-2", "3"]))
                                 .prompt("Favorite Number?", validation: MustBeThree.new)

        expect(validated_input).to include("3")
      end

      it "will display an error message if not valid" do
        validated_input = Display.new(stdout, FakeStandardIn.new(["-1", "-2", "3"]))
                                 .prompt("Favorite Number?", validation: MustBeThree.new)

        expect(stdout.messages).to include("-1 is not Three", "-2 is not Three")
      end
    end
  end
end
