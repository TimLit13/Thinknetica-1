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

  # Задать маршрут и передвинуть на 1 станцию маршрута
  def set_route(route)
    @route = route
    @current_station = @route.first
    @current_station_index = 0
  end

  # Переместить на следующую станцию
  def move_next_station
    if @current_station != @route.last
      @current_station_index += 1
      @current_station = @route[@current_station_index]
    end
  end

  # Переместить на предыдущую станцию
  def move_previous_station
    if @current_station != @route.first
      @current_station_index -= 1
      @current_station = @route[@current_station_index]
    end
  end

  # Возвращает предыдущую станцию. Если поезд на 1 станции, то возвращает ее
  def previous_station
    previous_station_index = 0
    if @current_station != @route.first
      previous_station_index = @current_station_index - 1
      @route[previous_station_index]
    else
      @route.first
    end
  end

  # Возвращает слудующую станцию. Если поезд на последней станции, то возвращает ее
  def next_station
    next_station_index = 0
    if current_station != @route.last
      next_station_index = @current_station_index + 1
      @route[next_station_index]
    else
      @route.last
    end
  end
end