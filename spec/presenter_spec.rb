require "spec_helper"
require "tictactoe"
require "ostruct"

RSpec.describe TextPresenter do
  subject(:presenter) { TextPresenter.new }

  class TextPresenter::FakeBoard
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
        board = TextPresenter::FakeBoard.new(outcome)
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
        board = TextPresenter::FakeBoard.new(outcome)
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
        board = TextPresenter::FakeBoard.new(outcome)

        expect(presenter.present(board)).to include("O wins!")
      end
    end

    context "when there is a draw" do
      it "displays the outcome" do
        outcome = OpenStruct.new(status: :draw, winner: nil)
        board = TextPresenter::FakeBoard.new(outcome)

        expect(presenter.present(board)).to include("Draw 😕")
      end
    end
  end
end
