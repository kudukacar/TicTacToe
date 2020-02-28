require "ostruct"

class Board
  def initialize
    @grid = Array.new(9)
    @tokens = {X: "X", O: "O"}
  end

  def place_token(position)
    grid[position - 1] = next_token
  end

  def get(position)
    grid[position - 1]
  end

  def is_available?(position)
    grid[position - 1].nil?
  end

  def outcome
    outcome = OpenStruct.new(status: :in_progress, winner: winner)
    outcome.status = :win if winner
    outcome.status = :draw if draw?
    outcome
  end

  def in_progress?
    outcome.status == :in_progress
  end

  def next_token
    grid.count(tokens[:X]) > grid.count(tokens[:O]) ? tokens[:O] : tokens[:X]
  end

  private

  attr_reader :grid, :tokens

  def draw?
    grid.none?(&:nil?) && !winner
  end

  def winner
    (rows + columns + diagonals).each do |triple|
      return tokens[:X] if triple.all? { |position| get(position) == tokens[:X] }
      return tokens[:O] if triple.all? { |position| get(position) == tokens[:O] }
    end
    nil
  end

  def rows
    [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
  end

  def columns
    [[1, 4, 7], [2, 5, 8], [3, 6, 9]]
  end

  def diagonals
    [[1, 5, 9], [3, 5, 7]]
  end
end
