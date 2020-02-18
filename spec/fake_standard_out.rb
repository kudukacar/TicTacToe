class FakeStandardOut
  attr_reader :log

  def initialize
    @log = ""
  end

  def puts(message)
    @log += message
    nil
  end
end
