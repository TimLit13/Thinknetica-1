class Station
  include InstanceCounter
  # Все методы public - так как все вызываются извне

  # возвращает список поездов на станции, Наименование станции
  attr_reader :trains_on_station, :name
  @station_instances = 0

  class << self
    attr_accessor :station_instances
  end

  # инициализирует станцию с именем, которое указывается при ее создании
  def initialize(name)
    @trains_on_station = []
    @name = name
    self.class.station_instances += 1
    register_instance
  end

  # Станция принимает поезд
  def train_arrive(train)
    @trains_on_station.push(train)
  end

  # Станция отправляет поезд
  def train_departure(train)
    @trains_on_station.delete(train)
  end

  # # Вывод на экран всех поездов на станции
  # def display_trains
  #   @trains_on_station.each_with_index do |train, i|
  #     puts "#{i+1}. Поезд #{train.number}"
  #   end
  # end

  # Возвращает список поездов на станции по заданному типу
  def trains_by_type(type)
    @trains_on_station.select { |train| train.type == type}
  end
end