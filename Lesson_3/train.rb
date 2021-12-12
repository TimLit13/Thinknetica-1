class Train

  # возвращаем скорость, количество вагонов 
  attr_reader :speed, :carriages_number, :current_station

  # Инициализируем объект с номером, типом и количеством вагонов
  def initialize(number, type, carriages_number)
    @number = number
    type.to_s.strip == "грузовой" ? @type = "грузовой" : @type = "пассажирский"
    @carriages_number = carriages_number
    @speed = 0
  end

  # Набрать заданную скорость
  def speed_increase(speed)
    @speed = speed
  end

  # остановиться
  def speed_decrease
    @speed = 0
  end

  # Прицепить вагон
  def add_carriage
    @carriages_number += 1 if @speed == 0
  end

  # Отцепить вагон
  def remove_carriage
    @carriages_number -= 1 if @speed == 0 && @carriages_number > 1
  end

  # Задать маршрут (@route - объект класса route) и передвинуть на 1 станцию маршрута
  def set_route(route)
    @route = route
    @current_station = @route.stations.first
  end

  # Переместить на следующую станцию, если она не конечная
  def move_next_station
    @current_station = next_station if next_station
  end

  # Переместить на предыдущую станцию, если она не первая в маршруте
  def move_previous_station
    @current_station = previous_station if previous_station
  end

  # Возвращает предыдущую станцию. Если поезд на 1 станции, то возвращает nil
  def previous_station
    @route.stations[@route.stations.index(@current_station) - 1] if @current_station != @route.stations.first
  end

  # Возвращает слудующую станцию. Если поезд на последней станции, то возвращает nil
  def next_station
    @route.stations[@route.stations.index(@current_station) + 1] if current_station != @route.stations.last
  end
end