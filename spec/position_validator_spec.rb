require "spec_helper"
require "game"

RSpec.describe PositionValidator do
  subject(:validator) { PositionValidator.new(board) }

  class BoardWithOneAvailable
    def is_available?(position)
      return 1 if position == 1
    end
  end

  describe "#error" do
    let(:board) { BoardWithOneAvailable.new }

    context "if the selection is not between 1 and 9" do
      it "returns an error message of invalid entry" do
        selection = 10

        expect(validator.error(selection)).to include("Invalid")
      end
    end

    context "if the selection is between 1 and 9 and is available on the board" do
      it "returns nil" do
        selection = 1

        expect(validator.error(selection)).to eq(nil)
      end
    end

    context "if the selection is between 1 and 9 but not available" do
      it "returns an error message of selection taken" do
        selection = 2

        expect(validator.error(selection)).to include("Selection taken")
      end
    end
  end
end
