require "spec_helper"
require "game"

RSpec.describe User do
  subject(:user) { User.new(display: display, parse_input: parse_input) }

  class FakeDisplay
    attr_reader :messages, :input

    def initialize(input: [])
      @messages = []
      @input = input
    end

    def output(message)
      @messages << message
      nil
    end

    def input
      @input.shift
    end
  end

  class FakeParseInput
    def to_integer(input)
      input.to_i
    end
  end

  class ValidatorWithOneValid
    def error(selection)
      return "Invalid entry" unless selection == 1
    end
  end

  describe "#valid_input" do
    let(:message) { "Please enter your selection" }
    let(:validator) { ValidatorWithOneValid.new }
    let(:parse_input) { FakeParseInput.new }

    context "with a valid entry of 1" do
      let(:display) { FakeDisplay.new(input: ["1"]) }

      it "prompts the user" do
        user.valid_input(message: message, validator: validator)

        expect(display.messages).to include(/Please enter your selection/)
      end

      it "returns the user's entry" do
        valid_input = user.valid_input(message: message, validator: validator)
        expect(valid_input).to eq(1)
      end
    end

    context "with an invalid entry" do
      let(:display) { FakeDisplay.new(input: ["2", "3", "1"]) }

      it "prompts the user for a response until receiving a valid entry" do
        user.valid_input(message: message, validator: validator)

        expect(display.messages).to contain_exactly(/Please enter your selection/, /Invalid/, \
          /Please enter your selection/, /Invalid/, /Please enter your selection/)
      end

      it "returns the user's entry" do
        valid_input = user.valid_input(message: message, validator: validator)
        expect(valid_input).to eq(1)
      end
    end
  end
end
