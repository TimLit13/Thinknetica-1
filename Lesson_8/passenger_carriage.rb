class PassengerCarriage < Carriage
  attr_reader :passengers_number

  def initialize(max_passenger_seats)
    @max_passenger_seats = max_passenger_seats
    @passengers_number = 0
    @type = 'Пассажирский'
    super
  end

  def add_passenger
    @passengers_number += 1 if @passengers_number < @max_passenger_seats
  end

  def free_seats
    @max_passenger_seats - @passengers_number
  end

  private

  attr_reader :max_passenger_seats

  def validate!
    raise 'Введено недопустимое количество пассажиров' unless @max_passenger_seats.between?(
      0, 54
    )
  end
end
