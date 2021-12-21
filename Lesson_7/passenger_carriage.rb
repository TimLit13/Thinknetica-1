class PassengerCarriage < Carriage

  attr_reader :passengers_number

  def initialize(max_passenger_seats)
    @max_passenger_seats = max_passenger_seats
    @passengers_number = 0
    @type = 'Пассажирский'
    validate!
  end

  def add_passenger
    (@passengers_number+1) < @max_passenger_seats ? @passengers_number += 1 : (puts "Все места уже заняты") 
  end

  def free_seats
    @max_passenger_seats - @passengers_number
  end

  private

  attr_reader :max_passenger_seats

  def validate!
    raise RuntimeError, "Введено недопустимое количество пассажиров" unless @max_passenger_seats.between?(0, 54)
  end
end