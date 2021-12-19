class PassengerTrain < Train
  def initialize(number, carriages_number)
    super
    @type = 'Пассажирский'
  end
end