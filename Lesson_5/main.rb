require_relative './company.rb'
require_relative './station.rb'
require_relative './route.rb'
require_relative './train.rb'
require_relative './cargo_train.rb'
require_relative './passenger_train.rb'
require_relative './carriage.rb'
require_relative './cargo_carriage.rb'
require_relative './passenger_carriage.rb'
require_relative './seed.rb'

class AppController
  # include Seed

  def initialize
    @stations = Array.new
    @trains = Array.new
    @routes = Array.new
  end

  def run
    loop do
      display_menu

      print 'Выберите действие: '

      user_choice = gets.strip.to_i
      case user_choice
      when 1
        create_station
      when 2
        create_train
      when 3
        create_or_change_route
      when 4
        set_route
      when 5
        add_carriage
      when 6
        remove_carriage
      when 7
        move_train
      when 8
        display_stations_list
      when 9
        display_trains_on_station
      when 0
        break
      else
        user_choice_mistake(user_choice)
      end
    end
  end

  private

  def create_station
    puts 'Введите наименование станции:'
    user_station = gets.strip.capitalize
    if user_station != ''
      @stations.push(Station.new(user_station))
    else
      user_choice_mistake(user_station)
    end
  end


  def create_train
    puts 'Введите тип поезда:'
      user_train_type = gets.strip
    puts 'Введите номер поезда:'
      user_train_name = gets.strip.to_i
  
    if user_train_type == 'Пассажирский' && user_train_name!=''
      @trains.push(PassengerTrain.new(user_train_name))
    elsif user_train_type == 'Грузовой' && user_train_name!=''
      @trains.push(CargoTrain.new(user_train_name))
    else 
      user_choice_mistake(user_train_type)
      puts "Или не введен номер поезда"
    end
  end


  def create_or_change_route
    display_route_menu
    user_choice = gets.strip.to_i
    case user_choice
    when 1
      create_new_route
    when 2
      add_station_to_route
    when 3
      remove_station_from_route
    when 0
      puts ""
    else
      user_choice_mistake(user_choice)
    end
  end

  def display_route_menu
    puts "Выберите действие:"
    puts "1 - Создать маршрут"
    puts "2 - Добавить станцию в маршрут"
    puts "3 - Удалить станцию из маршрута"
    puts "0 - Назад в меню"
  end

  def create_new_route
    display_stations_list
    puts "Введите название первой станции"
    user_route_first_station = gets.strip.capitalize
    puts "Введите название последней станции"
    user_route_last_station = gets.strip.capitalize

    if find_instance(@stations, user_route_first_station) && find_instance(@stations, user_route_last_station)      
      @routes.push(Route.new(find_instance(@stations, user_route_first_station), find_instance(@stations, user_route_last_station)))
      puts "Маршрут добавлен"
    else
      puts "Похоже одной из станций не существует. Сначала создайте станцию"
    end
  end

  def add_station_to_route
    if @routes.any?
      display_routes_list
      puts "Выберите маршрут"
      user_route = gets.strip.to_i
      
      if @routes[user_route - 1]
        display_stations_list
        puts "Введите название станции"
        user_station = gets.strip

        @stations.each do |station|
          if station.name == user_station
            @routes[user_route - 1].add_station(station) 
            puts "Станция добавлена в маршрут"
          end
        end        
      else
        puts "Такого маршрута нет"
      end
    else
      'В программе еще отсутствуют маршруты.'
    end
  end

  def remove_station_from_route
    if @routes.any?
      display_routes_list
      puts "Выберите маршрут"
      user_route = gets.strip.to_i
      
      if @routes[user_route - 1]
        puts "Станции на маршруте:"
        @routes[user_route - 1].stations.each do |station|
          puts "#{station.name}"
        end
        puts "Введите название станции"
        user_station = gets.strip.capitalize

        @routes[user_route - 1].remove_station(find_instance(@stations, user_station))
      else
        puts "Такого маршрута нет"
      end
    else
      'В программе еще отсутствуют маршруты.'
    end  
  end

  def set_route
    display_trains_list(@trains)
    puts "Введите номер поезда для добавления маршрута"
    user_train = gets.to_i
    train = find_instance(@trains, user_train) if find_instance(@trains, user_train)
    if train.nil?
      puts "Такой поезд отсутствует"
    else
      display_routes_list
      puts "Выберите маршрут"
      user_route = gets.to_i

      if @routes[user_route - 1]
        train.set_route(@routes[user_route - 1])
        @routes[user_route - 1].stations.first.train_arrive(train)
      else
        puts "Введен неправильный маршрут"
      end
    end
  end

  def add_carriage
    puts "Выберите поезд"
    display_trains_list(@trains)
    user_train = gets.strip.to_i
    if find_instance(@trains, user_train)
      train = find_instance(@trains, user_train)
      if train.type == 'Пассажирский' 
        train.add_carriage(PassengerCarriage.new)
        puts "Добавлен пассажирский вагон"
      else
        train.add_carriage(CargoCarriage.new)
        puts "Добавлен грузовой вагон"
      end
    else
      puts "Указанный поезд #{user_train} не найден.\nПопробуйте снова."
    end
  end

  def remove_carriage
    puts "Выберите поезд"
    display_trains_list(@trains)
    user_train = gets.strip.to_i
    if find_instance(@trains, user_train)
      train = find_instance(@trains, user_train) 
      train.remove_carriage
    else
      puts "Указанный поезд #{user_train} не найден.\nПопробуйте снова."
    end
  end

  def move_train
    puts "Выберите поезд"
    display_trains_list(@trains)
    user_train = gets.strip.to_i
    if find_instance(@trains, user_train)
      train = find_instance(@trains, user_train)
    else
      puts "Указанный поезд #{user_train} не найден.\nПопробуйте снова."
      return
    end
    puts "1 - Подвинуть поезд на следущую станцию"
    puts "2 - Подвинуть поезд на предыдущую станцию"
    case gets.to_i
    when 1
      train.move_next_station
    when 2
      train.move_previous_station
    else
      puts "Программе не удалось разобрать Ваш выбор"
    end
  end

  def display_trains_list(trains)
    puts '-' * 40
    puts "Список поездов:"
    trains.each_with_index do |train, i|
      puts "#{i+1} #{train.name}"
    end 
    puts '-' * 40
  end

  def display_routes_list
    puts '-' * 40
    puts "Список доступных маршрутов:"
    @routes.each_with_index do |route, i|
      puts "#{i+1} #{route.stations.first.name} - #{route.stations.last.name}"
    end 
    puts '-' * 40
  end


  def display_stations_list
    puts '-' * 40
    puts "Список доступных  станций:"
    @stations.each_with_index do |station, i|
      puts "#{i+1} #{station.name}"
    end 
    puts '-' * 40
  end

  def display_trains_on_station
    display_stations_list
    puts "Выберите нужную станцию"
    user_station = gets.strip.capitalize
    if find_instance(@stations, user_station)
      station = find_instance(@stations, user_station)
      puts "Выберите тип поезда"
      puts "1 - Пассажирский"
      puts "2 - Грузовой"
      case gets.to_i
      when 1
        type = "Пассажирский"
      when 2
        type = "Грузовой"
      else
        puts "Выбран неправильный тип поезда."
      end
      puts "Поезда на станции #{station.name}:"
      display_trains_list(station.trains_by_type(type)) if station.trains_by_type(type).any?
    else
      puts "Станция #{user_station} не найдена."
    end
  end

  def user_choice_mistake(user_choice)
    puts "Программа не распознала команду #{user_choice}."
  end

  def display_menu
    puts '=' * 40
    puts "Доступны следующие операции:"
    puts "1 - Создать станцию"
    puts "2 - Создать поезд"
    puts "3 - Создать маршрут и управлять станциями"
    puts "4 - Назначить маршрут"
    puts "5 - Добавить вагоны"
    puts "6 - Отцепить вагоны"
    puts "7 - Переместить поезд"
    puts "8 - Посмотреть список станций"
    puts "9 - Посмотреть список поездов на станции"
    puts "0 - Выход"
    puts '=' * 40
  end

  def find_instance(array_of_instances, instance_name)
    array_of_instances.find { |object| object.name == instance_name }
  end


end