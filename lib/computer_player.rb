class ComputerPlayer
  attr_reader :token

  def initialize(token)
    @token = token
  end

  def selection(board)
    loop do
      selection = rand(1..9)
      return selection if board.is_available?(selection)
    end
  end
end
