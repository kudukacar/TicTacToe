require "spec_helper"
require "game"

RSpec.describe OptionValidator do
  subject(:validator) { OptionValidator.new }

  describe "#error" do
    context "if the selection is between one and the number of options" do
      it "returns nil" do
        selection = 1
        validator.options = 2

        expect(validator.error(selection)).to eq(nil)
      end
    end

    context "if the selection is not between one and the number of options" do
      it "returns an error message of invalid entry" do
        selection = 4
        validator.options = 2

        expect(validator.error(selection)).to include("Invalid")
      end
    end
  end
end
