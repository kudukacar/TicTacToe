class Board
  attr_reader :tokens

  def initialize
    @board = Array.new(9)
    @tokens = {X: "X", O: "O"}
  end

  def place_token(pos, token)
    @board[pos - 1] = token
  end

  def get(pos)
    @board[pos - 1]
  end

  def next_token
    @board.count(tokens[:X]) > @board.count(tokens[:O]) ? tokens[:O] : tokens[:X]
  end

  def is_available?(pos)
    @board[pos - 1].nil?
  end
end
