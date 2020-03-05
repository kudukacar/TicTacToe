class ParseInput
  def to_integer(input)
    Integer(input)
  rescue
    0
  end
end
