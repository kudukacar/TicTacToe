class User
  attr_reader :display

  def initialize(display)
    @display = display
  end

  def valid_input(message:, parse_input:, validator:)
    loop do
      display.output(message)
      input = parse_input.to_integer(display.input)
      return input unless validator.error(input)
      display.output(validator.error(input))
    end
  end
end
