class Board
  def initialize
    @board = Array.new(9)
  end

  def place_token(pos, token)
    @board[pos - 1] = token
  end

  def [](pos)
    @board[pos]
  end
end
