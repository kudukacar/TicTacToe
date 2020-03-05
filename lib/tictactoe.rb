class TicTacToe
  attr_reader :presenter, :display, :board, :players

  def initialize(presenter, display, board, players)
    @presenter = presenter
    @display = display
    @board = board
    @players = players
  end

  def run
    show_board
    play_game
  end

  private

  def show_board
    display.output(presenter.present(board))
  end

  def play_turn(player)
    position = player.selection
    board.place_token(position, player.token)
  end

  def play_game
    players.cycle do |player|
      play_turn(player)
      show_board
      break unless in_progress?
    end
  end

  def in_progress?
    board.outcome.status == :in_progress
  end
end
