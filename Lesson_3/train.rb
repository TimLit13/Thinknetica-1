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

  # Переместить на следующую станцию
  def move_next_station
    if @current_station != @route.stations.last
      @current_station = find_next_station
  end

  # Переместить на предыдущую станцию
  def move_previous_station
    if @current_station != @route.stations.first
      @current_station_index -= 1
      @current_station = find_previous_station
    end
  end

  # Возвращает предыдущую станцию. Если поезд на 1 станции, то возвращает ее
  def previous_station
    if @current_station != @route.stations.first
      find_previous_station
    end
  end

  # Возвращает слудующую станцию. Если поезд на последней станции, то возвращает ее
  def next_station
    if current_station != @route.stations.last
      find_next_station
    end
  end

  private

  # поиск предыдущей станции для использования только внутри объекта класса
  def find_previous_station
    @route.stations[@route.stations.index(@current_station) - 1]
  end

  # поиск следующей станции для использования только внутри объекта класса
  def find_next_station
    @route.stations[@route.stations.index(@current_station) + 1]
  end
end