class OptionValidator
  attr_reader :options

  ERROR_MESSAGES = {
    invalid_entry: "Invalid entry.",
  }

  def initialize(options)
    @options = options
  end

  def error(selection)
    return ERROR_MESSAGES[:invalid_entry] unless selection.between?(1, options)
  end
end
