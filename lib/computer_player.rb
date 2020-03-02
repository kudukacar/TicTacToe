class ComputerPlayer
  attr_reader :token

  def initialize(token:)
    @token = token
  end

  def selection(board)
    available_positions = (1..9).to_a.filter { |position| board.is_available?(position) }
    available_positions.sample
  end
end
