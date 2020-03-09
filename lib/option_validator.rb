class OptionValidator
  attr_accessor :options

  ERROR_MESSAGES = {
    invalid_entry: "Invalid entry.",
  }

  def initialize
    @options = 1
  end

  def error(selection)
    return ERROR_MESSAGES[:invalid_entry] unless selection.between?(1, options)
  end
end
