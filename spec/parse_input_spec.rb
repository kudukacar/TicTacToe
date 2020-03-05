require "spec_helper"
require "game"

RSpec.describe ParseInput do
  describe "#input_to_integer" do
    context "with a user entered string of an integer" do
      it "converts the user entered string to an integer" do
        parse_input = ParseInput.new

        expect(parse_input.to_integer("5")).to eq(5)
      end
    end

    context "with a user entered non-integer string" do
      it "returns 0" do
        parse_input = ParseInput.new

        expect(parse_input.to_integer("?")).to eq(0)
      end
    end
  end
end
