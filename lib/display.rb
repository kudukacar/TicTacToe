class Display
  attr_reader :stdout, :stdin

  def initialize(stdout, stdin)
    @stdout = stdout
    @stdin = stdin
  end

  def output(message)
    stdout.puts message
  end

  def input
    stdin.gets.strip
  end

  def prompt(message, parse: PassThroughParse.new, validation: PassThroughValidator.new)
    loop do
      output(message)
      user_input = input
      if error = validation.errors_for(user_input)
        output(error)
      else
        return parse.call(user_input)
      end
    end
  end

  private

  class PassThroughParse
    def call(input)
      input
    end
  end

  class PassThroughValidator
    def errors_for(input)
    end
  end
end
