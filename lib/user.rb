class User
  attr_reader :display, :parse_input

  def initialize(display:, parse_input:)
    @display = display
    @parse_input = parse_input
  end

  def valid_input(message:, validator:)
    loop do
      display.output(message)
      input = parse_input.to_integer(display.input)
      return input unless validator.error(input)
      display.output(validator.error(input))
    end
  end
end
