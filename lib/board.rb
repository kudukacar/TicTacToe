class Board
  def initialize
    @board = Array.new(9)
  end

  def place_token(pos, token)
    @board[pos - 1] = token
  end

  def get(pos)
    @board[pos - 1]
  end

  def next_token
    @board.count("X") > @board.count("O") ? "O" : "X"
  end

  def is_available?(pos)
    @board[pos - 1].nil?
  end
end
