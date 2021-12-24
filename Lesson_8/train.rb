class Train
  include Company
  include InstanceCounter
  include CheckValidation

  TRAIN_NUMBER_PATTERN = /^[a-zA-Z||а-яА-Я||\d]{3}-?[a-zA-Z||а-яА-Я||\d]{2}$/

  # все методы, кроме private так или иначе используются извне класса, поэтому public
  # возвращаем скорость, количество вагонов
  attr_reader :speed, :carriages, :current_station, :type, :name

  @@trains = []

  def self.find(number)
    @@trains.find { |train| train.name == number }
  end

  def initialize(number)
    @name = number
    @carriages = []
    @carriages_number = 0
    @speed = 0
    validate!
    @@trains.push(self)
    register_instance
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
  def add_carriage(carriage)
    @carriages.push(carriage) if @speed.zero? && type == carriage.type
  end

  # Отцепить вагон
  def remove_carriage
    @carriages.pop if @speed.zero? && @carriages.any?
  end

  # Задать маршрут (@route - объект класса route) и передвинуть на 1 станцию маршрута
  def set_route(route)
    @route = route
    @current_station = @route.stations.first
    @current_station.train_arrive(self)
  end

  # Переместить на следующую станцию, если она не конечная
  def move_next_station
    @current_station = next_station if next_station
    @current_station.train_arrive(self)
    previous_station.train_departure(self)
  end

  # Переместить на предыдущую станцию, если она не первая в маршруте
  def move_previous_station
    @current_station = previous_station if previous_station
    @current_station.train_arrive(self)
    next_station.train_departure(self)
  end

  # block можно опустить
  def all_carriages_in_train
    @carriages.each_with_index(&block) if block_given?
  end

  private

  # Возвращает предыдущую станцию. Если поезд на 1 станции, то возвращает nil
  # Независимо от класса потомка, реализация метода не изменится.
  # Используется только внутри класса
  def previous_station
    if @current_station != @route.stations.first
      @route.stations[@route.stations.index(@current_station) - 1]
    end
  end

  # Возвращает слудующую станцию. Если поезд на последней станции, то возвращает nil
  # Независимо от класса потомка, реализация метода не изменится.
  # Используется только внутри класса
  def next_station
    if current_station != @route.stations.last
      @route.stations[@route.stations.index(@current_station) + 1]
    end
  end

  def validate!
    unless @name =~ TRAIN_NUMBER_PATTERN
      raise "Номер поезда не соответствует шаблону.\nШаблон: Три символа, дефис, два символа\nПример: 'qwe-qw' или '123-12'"
    end
    raise 'Недопустимое количество вагонов' if @carriages_number < 0
  end
end
