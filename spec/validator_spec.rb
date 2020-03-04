require "spec_helper"
require "tictactoe"

RSpec.describe SelectionValidator do
  subject(:validator) { SelectionValidator.new }

  class BoardWithOneAvailable
    def is_available?(position)
      return 1 if position == 1
    end
  end

  describe "#validate_board_position" do
    let(:board) { BoardWithOneAvailable.new }

    context "if the selection is not between 1 and 9" do
      it "returns an error message of invalid entry" do
        selection = 10

        expect(validator.validate_board_position(selection, board)).to include("Invalid")
      end
    end

    context "if the selection is between 1 and 9 and is available on the board" do
      it "returns the selection" do
        selection = 1

        expect(validator.validate_board_position(selection, board)).to eq(1)
      end
    end

    context "if the selection is between 1 and 9 but not available" do
      it "returns an error message of selection taken" do
        selection = 2

        expect(validator.validate_board_position(selection, board)).to include("Selection taken")
      end
    end
  end

  describe "#validate_game_option" do
    context "if the selection is between one and the options length" do
      it "returns the selection" do
        selection = 1
        options_count = 2

        expect(validator.validate_game_option(selection, options_count)).to eq(1)
      end
    end

    context "if the selection is not between one and the options length" do
      it "returns an error message of invalid entry" do
        selection = 4
        options_count = 2

        expect(validator.validate_game_option(selection, options_count)).to include("Invalid")
      end
    end
  end
end
