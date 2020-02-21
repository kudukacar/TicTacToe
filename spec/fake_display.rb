class FakeDisplay
  attr_reader :messages

  def initialize(inputs: [])
    @inputs = inputs
    @messages = []
  end

  def output(message)
    @messages << message
    nil
  end

  def input
    @inputs.shift
  end
end
