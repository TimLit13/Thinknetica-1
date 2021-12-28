class Carriage
  include Company

  attr_reader :type

  def initialize(_max)
    validate!
  end
end
