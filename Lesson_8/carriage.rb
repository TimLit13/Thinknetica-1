class Carriage
  include Company

  attr_reader :type

  def initialize(max)
    validate!
  end

end