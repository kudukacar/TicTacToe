require "ostruct"

class Board
  def initialize
    @grid = Array.new(9)
  end

  def place_token(position, token)
    grid[position - 1] = token
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

  private

  attr_reader :grid

  def draw?
    grid.none?(&:nil?) && !winner
  end

  def winner
    (rows + columns + diagonals).each do |triple|
      return get(triple[0]) if triple.all? { |position| get(position) == get(triple[0]) }
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
