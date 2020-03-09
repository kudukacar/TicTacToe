class ComputerPlayer
  attr_reader :token, :board

  def initialize(token:, board:)
    @token = token
    @board = board
  end

  def selection
    available_positions.sample
  end

  def available_positions
    (1..9).to_a.filter { |position| board.is_available?(position) }
  end
end
