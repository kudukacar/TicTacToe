class Board
  attr_reader :board, :tokens

  def initialize
    @board = Array.new(9)
    @tokens = {X: "X", O: "O"}
  end

  def place_token(pos)
    board[pos - 1] = next_token
  end

  def get(pos)
    board[pos - 1]
  end

  def is_available?(pos)
    board[pos - 1].nil?
  end

  def game_over?
    win? || tie?
  end

  private

  def next_token
    board.count(tokens[:X]) > board.count(tokens[:O]) ? tokens[:O] : tokens[:X]
  end

  def rows
    [board[0..2], board[3..5], board[6..8]]
  end

  def columns
    [
      [board[0], board[3], board[6]],
      [board[1], board[4], board[7]],
      [board[2], board[5], board[6]],
    ]
  end

  def diagonals
    [
      [board[0], board[4], board[8]],
      [board[2], board[4], board[6]],
    ]
  end

  def tie?
    board.none?(&:nil?)
  end

  def win?
    (rows + columns + diagonals).any? do |triple|
      triple.all? { |pos| pos == tokens[:X] } || triple.all? { |pos| pos == tokens[:O] }
    end
  end
end
