class Display
  def initialize(stdout)
    @stdout = stdout
  end

  def output(message)
    @stdout.puts message
  end
end