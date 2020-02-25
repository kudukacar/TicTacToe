class Board
  def initialize
    @board = Array.new(9)
    @tokens = {X: "X", O: "O"}
  end

  def place_token(position)
    board[position - 1] = next_token
  end

  def get(position)
    board[position - 1]
  end

  def is_available?(position)
    board[position - 1].nil?
  end

  def outcome
    winner || draw?
  end

  private

  attr_reader :board, :tokens

  def next_token
    board.count(tokens[:X]) > board.count(tokens[:O]) ? tokens[:O] : tokens[:X]
  end

  def rows
    [[0, 1, 2], [3, 4, 5], [6, 7, 8]]
  end

  def columns
    [[0, 3, 6], [1, 4, 7], [2, 5, 8]]
  end

  def diagonals
    [[0, 4, 8], [2, 4, 6]]
  end

  def draw?
    board.none?(&:nil?)
  end

  def winner
    (rows + columns + diagonals).each do |triple|
      return tokens[:X] if triple.all? { |position| board[position] == tokens[:X] }
      return tokens[:O] if triple.all? { |position| board[position] == tokens[:O] }
    end
    false
  end
end
