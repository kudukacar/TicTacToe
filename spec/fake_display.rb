class FakeDisplay
  attr_reader :messages, :inputs

  def initialize(inputs: [])
    @messages = []
    @inputs = inputs
  end

  def output(message)
    @messages << message
    nil
  end

  def input
    @inputs.shift
  end
end
