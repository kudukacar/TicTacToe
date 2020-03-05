require "spec_helper"
require "game"

RSpec.describe OptionValidator do
  subject(:validator) { OptionValidator.new(options) }

  describe "#error" do
    let(:options) { 2 }

    context "if the selection is between one and the options length" do
      it "returns nil" do
        selection = 1

        expect(validator.error(selection)).to eq(nil)
      end
    end

    context "if the selection is not between one and the options length" do
      it "returns an error message of invalid entry" do
        selection = 4

        expect(validator.error(selection)).to include("Invalid")
      end
    end
  end
end
