require "spec_helper"
require "tictactoe"
require "ostruct"

RSpec.describe TextPresenter do
  subject(:presenter) { TextPresenter.new }

  class BoardWithOutcomeInstance
    attr_reader :outcome

    def initialize(outcome)
      @outcome = outcome
    end

    def get(position)
      if [1, 2, 3].include?(position)
        "X"
      end
    end
  end

  describe "#present" do
    context "without an outcome" do
      it "formats the board" do
        outcome = OpenStruct.new(status: :in_progress, winner: nil)
        board = BoardWithOutcomeInstance.new(outcome)
        blank_string = " "
        expected_board = <<~BOARD

           X | X | X
          ---+---+---
             |   | #{blank_string}
          ---+---+---
             |   | #{blank_string}

        BOARD
        expected_outcome = ""

        expect(presenter.present(board)).to eq(expected_board + expected_outcome)
      end
    end

    context "when X wins" do
      it "displays the board and the outcome" do
        outcome = OpenStruct.new(status: :win, winner: "X")
        board = BoardWithOutcomeInstance.new(outcome)
        blank_string = " "
        expected_board = <<~BOARD

           X | X | X
          ---+---+---
             |   | #{blank_string}
          ---+---+---
             |   | #{blank_string}

        BOARD
        expected_outcome = "X wins!"

        expect(presenter.present(board)).to eq(expected_board + expected_outcome)
      end
    end

    context "when O wins" do
      it "displays the board and the outcome" do
        outcome = OpenStruct.new(status: :win, winner: "O")
        board = BoardWithOutcomeInstance.new(outcome)

        expect(presenter.present(board)).to include("O wins!")
      end
    end

    context "when there is a draw" do
      it "displays the outcome" do
        outcome = OpenStruct.new(status: :draw, winner: nil)
        board = BoardWithOutcomeInstance.new(outcome)

        expect(presenter.present(board)).to include("Draw 😕")
      end
    end
  end

  describe "#show_error" do
    context "when the entry is invalid" do
      it "displays the invalid error message" do
        error = :invalid_entry

        expect(presenter.show_error(error)).to include("Invalid")
      end
    end

    context "when the entry is taken" do 
      it "displays the space_taken error message" do
        error = :space_taken

        expect(presenter.show_error(error)).to include("Selection taken")
      end
    end
  end

  describe "#prompt_player" do
    it "prompts the appropriate player" do
      player = "X"

      expect(presenter.prompt_player(player)).to include("X")
    end
  end

  describe "#select_position" do
    it "prompts the player to select a position" do
      expect(presenter.select_position).to include("Please select")
    end
  end
end
