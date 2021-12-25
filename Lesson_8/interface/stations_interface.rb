class StationsInterface
  include FindInstance

  attr_accessor :stations

  def initialize
    @stations = []
  end

  def index
    puts '-' * 40
    puts 'Список доступных  станций:'
    @stations.each_with_index do |station, i|
      puts "#{i + 1} #{station.name}"
    end
    puts '-' * 40
  end

  def create
    puts 'Введите наименование станции:'
    user_station = gets.strip.capitalize
    if user_station != ''
      @stations.push(Station.new(user_station))
    else
      user_choice_mistake(user_station)
    end
  end

  def display_trains_on_station
    index
    puts 'Выберите нужную станцию'
    user_station = gets.strip.capitalize
    if find_instance(@stations, user_station)
      station = find_instance(@stations, user_station)
      puts 'Выберите тип поезда'
      puts '1 - Пассажирский'
      puts '2 - Грузовой'
      puts '3 - Любой'
      case gets.to_i
      when 1
        type = 'Пассажирский'
      when 2
        type = 'Грузовой'
      when 3
        display_all_trains_on_station(station)
      else
        puts 'Выбран неправильный тип поезда.'
      end
      display_trains_list(station.trains_by_type(type)) if station.trains_by_type(type).any?
    else
      puts "Станция #{user_station} не найдена."
    end
  end

  private

  def display_all_trains_on_station(station)
    my_proc = proc do |train|
      print "Поезд № #{train.name}\t"
      print "тип: #{train.type}\t"
      puts "количество вагонов: #{train.carriages.any? ? train.carriages.length : 0}"
      return
    end
    station.all_trains_on_station(&my_proc) if station.trains_on_station.any?
    puts 'поезда на станции отсутствуют' unless station.trains_on_station.any?
  end
end
