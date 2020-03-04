require "spec_helper"
require "tictactoe"
require "ostruct"

RSpec.describe SelectionValidator do
  subject(:validator) { SelectionValidator.new }

  class BoardWithOneAvailable
    def is_available?(position)
      return 1 if position == 1
    end
  end

  describe "#validate" do
    let(:board) { BoardWithOneAvailable.new }

    context "if the selection is not between 1 and 9" do
      it "returns an object with a status of invalid_entry and a position of nil" do
        selection = 10

        expect(validator.validate(selection, board)).to have_attributes(status: :invalid_entry, position: nil)
      end
    end

    context "if the selection is between 1 and 9 and is available on the board" do
      it "returns an object with the selection" do
        selection = 1

        expect(validator.validate(selection, board)).to have_attributes(position: 1)
      end
    end

    context "if the selection is between 1 and 9 but not available" do
      it "returns an object with a status of :space_taken and a position of nil" do
        selection = 2

        expect(validator.validate(selection, board)).to have_attributes(status: :space_taken, position: nil)
      end
    end
  end
end
