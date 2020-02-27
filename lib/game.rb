require "ostruct"

class Game
  def outcome(board)
    outcome = OpenStruct.new(status: :in_progress, winner: winner(board))
    outcome.status = :win if winner(board)
    outcome.status = :draw if draw?(board)
    outcome
  end

  private

  def draw?(board)
    (1..9).none? { |position| board.get(position).nil? } && !winner(board)
  end

  def winner(board)
    (rows + columns + diagonals).each do |triple|
      return board.tokens[:X] if triple.all? { |position| board.get(position) == board.tokens[:X] }
      return board.tokens[:O] if triple.all? { |position| board.get(position) == board.tokens[:O] }
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
