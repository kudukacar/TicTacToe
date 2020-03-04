require "spec_helper"
require "parse_input"

RSpec.describe ParseInput do
  class DisplayWithOnlyInput
    attr_reader :input

    def initialize(input: [])
      @input = input
    end

    def input
      @input.shift
    end
  end

  describe "#input_to_integer" do
    context "with a user entered string of an integer" do
      it "converts the user entered string to an integer" do
        display = DisplayWithOnlyInput.new(input: ["5"])
        parse_input = ParseInput.new(display)

        expect(parse_input.input_to_integer).to eq(5)
      end
    end

    context "with a user entered non-integer string" do
      it "returns 0" do
        display = DisplayWithOnlyInput.new(input: ["?"])
        parse_input = ParseInput.new(display)

        expect(parse_input.input_to_integer).to eq(0)
      end
    end
  end
end