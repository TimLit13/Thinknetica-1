class Route

  # Создаем маршрут с первой станцией и конечной станцией
  def initialize(first_station, last_station)
    @stations=[first_station, last_station]
  end

  # Показать все станции на маршруте
  def display_stations
    @stations.each_with_index do |station, i|
      puts "#{i+1}. station: #{station}"
    end
  end

  # Добавить станцию в маршрут, если ее еще нет
  def add_station(station)
    @staions.insert(@stations.length-1, station) unless @stations.include?(station)
  end

  # Удалить станцию из маршрута, если такая станция есть в маршруте
  def remove_station(station)
    if @stations.include?(station) || @stations[0] != station || @stations[-1] != station
       @stations.delete(station)
    end
  end
end