class Board
  attr_reader :grid, :tokens

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

  private

  def next_token
    grid.count(tokens[:X]) > grid.count(tokens[:O]) ? tokens[:O] : tokens[:X]
  end
end
