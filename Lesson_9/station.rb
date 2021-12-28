class Station
  include InstanceCounter
  include CheckValidation
  include Validation
  include Accessors
  # Все методы public - так как все вызываются извне

  NAME_PATTERN = /^\w{3,}$/.freeze

  # возвращает список поездов на станции, Наименование станции
  attr_reader :trains_on_station, :name

  validate :name, :format, NAME_PATTERN
  # validate :name, :type, String

  @station_instances = 0

  class << self
    attr_accessor :station_instances
  end

  # инициализирует станцию с именем, которое указывается при ее создании
  def initialize(name)
    @trains_on_station = []
    @name = name
    validate!
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
  #   endgit push --set-upstream origin Tasks_for_Lesson_6_(validation)
  # end

  # Возвращает список поездов на станции по заданному типу
  def trains_by_type(type)
    @trains_on_station.select { |train| train.type == type }
  end

  # &block можно опустить
  def all_trains_on_station
    @trains_on_station.each { |train| yield(train) } if block_given? && @trains_on_station.any?
  end

  # private

  # def validate!
  #   raise 'В названии станции должно быть не менее трех символов' if @name.length < 3
  # end
end
