class CargoTrain < Train
  def initialize(number, carriages_number)
    super
    @type = 'Грузовой'
  end
end