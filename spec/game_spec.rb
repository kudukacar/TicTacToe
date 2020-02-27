require "spec_helper"
require "tictactoe"

RSpec.describe Game do
  subject(:game) { Game.new }
  let(:token) { "X" }

  class Game::BoardWithOutcome
    attr_reader :grid, :tokens

    def initialize(grid)
      @grid = grid
      @tokens = {X: "X", O: "O"}
    end

    def get(position)
      return tokens[:X] if grid.include?(position)
      tokens[:O]
    end
  end

  class Game::BoardWithNoOutcome
    attr_reader :grid, :tokens

    def initialize(grid)
      @grid = grid
      @tokens = {X: "X"}
    end

    def get(position)
      return tokens[:X] if grid.include?(position)
      nil
    end
  end

  def set_draw
    Game::BoardWithOutcome.new([1, 3, 6, 7, 8])
  end

  def set_diagonal_winner
    Game::BoardWithOutcome.new([1, 3, 5, 8, 9])
  end

  def set_column_winner
    Game::BoardWithOutcome.new([1, 4, 7])
  end

  def set_row_winner
    Game::BoardWithOutcome.new([1, 2, 3])
  end

  def set_no_outcome
    Game::BoardWithNoOutcome.new([1, 3])
  end

  describe "#outcome" do
    context "with a diagonal winner" do
      it "returns an object with a status of win and the diagonal winner" do
        board = set_diagonal_winner
        outcome = game.outcome(board)

        expect([outcome.status, outcome.winner]).to contain_exactly(:win, token)
      end
    end

    context "with a column winner" do
      it "returns an object with a status of win and the column winner" do
        board = set_column_winner
        outcome = game.outcome(board)

        expect([outcome.status, outcome.winner]).to contain_exactly(:win, token)
      end
    end

    context "with a row winner" do
      it "returns an object with a status of win and the row winner" do
        board = set_row_winner
        outcome = game.outcome(board)

        expect([outcome.status, outcome.winner]).to contain_exactly(:win, token)
      end
    end

    context "with a draw" do
      it "returns an object with a status of draw and a winner of nil" do
        board = set_draw
        outcome = game.outcome(board)

        expect([outcome.status, outcome.winner]).to contain_exactly(:draw, nil)
      end
    end

    context "with no outcome" do
      it "returns an object with a status of in_progress and winner of nil" do
        board = set_no_outcome
        outcome = game.outcome(board)

        expect([outcome.status, outcome.winner]).to contain_exactly(:in_progress, nil)
      end
    end
  end
end
