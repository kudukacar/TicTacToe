require_relative "./display"
require_relative "./presenter"
require_relative "./board"
require_relative "./human_player"
require_relative "./computer_player"

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

  def play_turn(turns)
    current_player = players[turns % 2]
    position = current_player.selection(board)
    board.place_token(position, current_player.token)
  end

  def play_game
    turns = 0
    while board.in_progress?
      play_turn(turns)
      show_board
      turns += 1
    end
  end
end

if $PROGRAM_NAME == __FILE__
  display = Display.new($stdout, $stdin)
  presenter = TextPresenter.new
  board = Board.new
  player = HumanPlayer.new(display, "X")
  other_player = ComputerPlayer.new("O")
  players = [player, other_player]
  TicTacToe.new(presenter, display, board, players).run
end
