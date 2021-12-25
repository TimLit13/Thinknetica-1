class Route
  include InstanceCounter
  include CheckValidation
  # Все методы public - так как все вызываются извне

  attr_reader :stations

  # Создаем маршрут с первой станцией и конечной станцией
  def initialize(first_station, last_station)
    @stations = [first_station, last_station]
    validate!
    register_instance
  end

  # # Показать все станции на маршруте
  # def display_stations
  #   @stations.each_with_index do |station, i|
  #     puts "#{i+1}. station: #{station}"
  #   end
  # end

  # Добавить станцию в маршрут, если ее еще нет
  def add_station(station)
    @stations.insert(-2, station) unless @stations.include?(station)
  end

  # Удалить станцию из маршрута, если такая станция есть в маршруте
  def remove_station(station)
    @stations.delete(station) if @stations.include?(station) || @stations[0] != station || @stations[-1] != station
  end

  private

  def validate!
    raise 'Первая станция маршрута не может быть конечной' if @stations[0] == @stations[1]
  end
end
