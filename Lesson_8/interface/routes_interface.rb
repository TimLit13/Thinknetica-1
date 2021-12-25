class RoutesInterface
  include FindInstance

  attr_accessor:routes

  def initialize
    @routes = []
  end

  def index
    puts '-' * 40
    puts 'Список доступных маршрутов:'
    @routes.each_with_index do |route, i|
      puts "#{i + 1} #{route.stations.first.name} - #{route.stations.last.name}"
    end
    puts '-' * 40
  end

  def create(stations_interface)
    puts 'Введите название первой станции'
    user_route_first_station = gets.strip.capitalize
    puts 'Введите название последней станции'
    user_route_last_station = gets.strip.capitalize

    if find_instance(stations_interface.stations,
                     user_route_first_station) && find_instance(stations_interface.stations,
                                                                user_route_last_station)
      @routes.push(Route.new(find_instance(stations_interface.stations, user_route_first_station),
                             find_instance(stations_interface.stations, user_route_last_station)))
      puts 'Маршрут добавлен'
    else
      puts 'Похоже одной из станций не существует. Сначала создайте станцию'
    end
  end

  def update(stations_interface)
     if @routes.any?
      index
      puts 'Выберите маршрут'
      user_route = gets.strip.to_i

      if @routes[user_route - 1]
        stations_interface.index
        puts 'Введите название станции'
        user_station = gets.strip

        stations_interface.stations.each do |station|
          if station.name == user_station
            @routes[user_route - 1].add_station(station)
            puts 'Станция добавлена в маршрут'
          end
        end
      else
        puts 'Такого маршрута нет'
      end
    else
      'В программе еще отсутствуют маршруты.'
    end
  end

  def destroy(stations_interface)
    if @routes.any?
      index
      puts 'Выберите маршрут'
      user_route = gets.strip.to_i

      if @routes[user_route - 1]
        puts 'Станции на маршруте:'
        @routes[user_route - 1].stations.each do |station|
          puts station.name.to_s
        end
        puts 'Введите название станции'
        user_station = gets.strip.capitalize

        @routes[user_route - 1].remove_station(find_instance(stations_interface.stations,
                                                             user_station))
      else
        puts 'Такого маршрута нет'
      end
    else
      'В программе еще отсутствуют маршруты.'
    end
  end

end