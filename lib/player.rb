class Player
  def initialize(display)
    @display = display
  end

  def move
    loop do
      @display.output("Please select your move by entering the number (1 - 9) corresponding to an empty space.  The spaces are numbered from the top left (1) to the bottom right (9) of the board.")

      selection = begin
                    Integer(@display.input)
                  rescue
                    0
                  end

      if selection.between?(1, 9)
        return selection - 1
      else
        @display.output("Invalid entry.")
      end
    end
  end
end
