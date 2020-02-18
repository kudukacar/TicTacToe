require_relative "./display"
require_relative "./presenter"

class TicTacToe
  def initialize(presenter, display)
    @presenter = presenter
    @display = display
  end

  def run
    @display.output(@presenter.display_board)
  end
end

if $PROGRAM_NAME == __FILE__
  display = Display.new($stdout)
  presenter = Presenter.new
  TicTacToe.new(presenter, display).run
end
