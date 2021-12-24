require_relative './company'
require_relative './instance_counter'
require_relative './check_validation'
require_relative './station'
require_relative './route'
require_relative './train'
require_relative './cargo_train'
require_relative './passenger_train'
require_relative './carriage'
require_relative './cargo_carriage'
require_relative './passenger_carriage'
require_relative './seed'

class AppController
  include Seed

  def initialize
    @stations = []
    @trains = []
    @routes = []
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
      when 10
        display_carriages_list
      when 11
        fill_carriage
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
    attempts = 0
    begin
      puts 'Введите тип поезда:'
      user_train_type = gets.strip
      puts 'Введите номер поезда:'
      user_train_name = gets.strip
      puts 'Укажите количество вагонов'
      user_carriages_number = gets.strip.to_i

      if user_train_type == 'Пассажирский'
        @trains.push(PassengerTrain.new(user_train_name, user_carriages_number))
      elsif user_train_type == 'Грузовой'
        @trains.push(CargoTrain.new(user_train_name, user_carriages_number))
      else
        raise 'Введен неправильный тип поезда'
      end
    rescue RuntimeError => e
      attempts += 1
      puts e.message.to_s
      if attempts < 3
        puts 'Не удалось создать поезд. Попробуйте снова'
        puts "Осталось попыток: #{3 - attempts}"
        retry
      else
        puts "Не удалось создать поезд.\nВыход в меню."
      end
    end
    if attempts < 3
      puts "#{user_train_type} поезд ##{user_train_name} с количеством вагонов: #{user_carriages_number} успешно создан"
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
      puts ''
    else
      user_choice_mistake(user_choice)
    end
  end

  def display_route_menu
    puts 'Выберите действие:'
    puts '1 - Создать маршрут'
    puts '2 - Добавить станцию в маршрут'
    puts '3 - Удалить станцию из маршрута'
    puts '0 - Назад в меню'
  end

  def create_new_route
    display_stations_list
    puts 'Введите название первой станции'
    user_route_first_station = gets.strip.capitalize
    puts 'Введите название последней станции'
    user_route_last_station = gets.strip.capitalize

    if find_instance(@stations,
                     user_route_first_station) && find_instance(@stations,
                                                                user_route_last_station)
      @routes.push(Route.new(find_instance(@stations, user_route_first_station),
                             find_instance(@stations, user_route_last_station)))
      puts 'Маршрут добавлен'
    else
      puts 'Похоже одной из станций не существует. Сначала создайте станцию'
    end
  end

  def add_station_to_route
    if @routes.any?
      display_routes_list
      puts 'Выберите маршрут'
      user_route = gets.strip.to_i

      if @routes[user_route - 1]
        display_stations_list
        puts 'Введите название станции'
        user_station = gets.strip

        @stations.each do |station|
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

  def remove_station_from_route
    if @routes.any?
      display_routes_list
      puts 'Выберите маршрут'
      user_route = gets.strip.to_i

      if @routes[user_route - 1]
        puts 'Станции на маршруте:'
        @routes[user_route - 1].stations.each do |station|
          puts station.name.to_s
        end
        puts 'Введите название станции'
        user_station = gets.strip.capitalize

        @routes[user_route - 1].remove_station(find_instance(@stations,
                                                             user_station))
      else
        puts 'Такого маршрута нет'
      end
    else
      'В программе еще отсутствуют маршруты.'
    end
  end

  def set_route
    display_trains_list(@trains)
    puts 'Введите номер поезда для добавления маршрута'
    user_train = gets.to_i
    train = find_instance(@trains, user_train) if find_instance(@trains,
                                                                user_train)
    if train.nil?
      puts 'Такой поезд отсутствует'
    else
      display_routes_list
      puts 'Выберите маршрут'
      user_route = gets.to_i

      if @routes[user_route - 1]
        train.set_route(@routes[user_route - 1])
        @routes[user_route - 1].stations.first.train_arrive(train)
      else
        puts 'Введен неправильный маршрут'
      end
    end
  end

  def add_carriage
    attempts = 0
    puts 'Выберите поезд'
    display_trains_list(@trains)
    user_train = gets.strip
    begin
      if find_instance(@trains, user_train)
        train = find_instance(@trains, user_train)
        if train.type == 'Пассажирский'
          puts 'Введите количество мест в вагоне'
          train.add_carriage(PassengerCarriage.new(gets.to_i))
          puts 'Добавлен пассажирский вагон'
        else
          puts 'Введите общий объем вагона'
          train.add_carriage(CargoCarriage.new(gets.to_f))
          puts 'Добавлен грузовой вагон'
        end
      else
        puts "Указанный поезд #{user_train} не найден.\nПопробуйте снова."
      end
    rescue RuntimeError => e
      attempts += 1
      puts e.message.to_s
      if attempts < 3
        puts 'Не удалось добавить вагон. Попробуйте снова'
        puts "Осталось попыток: #{3 - attempts}"
        retry
      else
        puts "Не удалось сдобавить вагон.\nВыход в меню."
      end
    end
  end

  def remove_carriage
    puts 'Выберите поезд'
    display_trains_list(@trains)
    user_train = gets.strip
    if find_instance(@trains, user_train)
      train = find_instance(@trains, user_train)
      train.remove_carriage
    else
      puts "Указанный поезд #{user_train} не найден.\nПопробуйте снова."
    end
  end

  def move_train
    puts 'Выберите поезд'
    display_trains_list(@trains)
    user_train = gets.strip.to_i
    if find_instance(@trains, user_train)
      train = find_instance(@trains, user_train)
    else
      puts "Указанный поезд #{user_train} не найден.\nПопробуйте снова."
      return
    end
    puts '1 - Подвинуть поезд на следущую станцию'
    puts '2 - Подвинуть поезд на предыдущую станцию'
    case gets.to_i
    when 1
      train.move_next_station
    when 2
      train.move_previous_station
    else
      puts 'Программе не удалось разобрать Ваш выбор'
    end
  end

  def display_trains_list(trains)
    puts '-' * 40
    puts 'Список поездов:'
    trains.each_with_index do |train, i|
      puts "#{i + 1} #{train.name}"
    end
    puts '-' * 40
  end

  def display_routes_list
    puts '-' * 40
    puts 'Список доступных маршрутов:'
    @routes.each_with_index do |route, i|
      puts "#{i + 1} #{route.stations.first.name} - #{route.stations.last.name}"
    end
    puts '-' * 40
  end

  def display_stations_list
    puts '-' * 40
    puts 'Список доступных  станций:'
    @stations.each_with_index do |station, i|
      puts "#{i + 1} #{station.name}"
    end
    puts '-' * 40
  end

  def display_trains_on_station
    display_stations_list
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
      puts "Поезда на станции #{station.name}:"
      if station.trains_by_type(type).any?
        display_trains_list(station.trains_by_type(type))
      end
    else
      puts "Станция #{user_station} не найдена."
    end
  end

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

  def user_choice_mistake(user_choice)
    puts "Программа не распознала команду #{user_choice}."
  end

  def display_carriages_list
    puts 'Выберите поезд'
    display_trains_list(@trains)
    user_train = gets.strip
    if find_instance(@trains, user_train)
      train = find_instance(@trains, user_train)
      if train.carriages.length > 0
        l = lambda do |carriage, index|
          print "Вагон № #{index + 1}\t"
          print "#{carriage.type}\t"
          if carriage.type == 'Пассажирский'
            print "Занято мест: #{carriage.passengers_number}\t"
            puts "Свободно мест: #{carriage.free_seats}\t"
          else
            print "Занято объема: #{carriage.filled_volume.round(2)}\t"
            puts "Свободно объема: #{carriage.available_volume.round(2)}\t"
          end
        end
        train.all_carriages_in_train(&l)
      else
        puts 'К поезду пока что вагоны не прицеплены.'
      end
    else
      puts 'Указанный поезд не найден'
    end
  end

  def fill_carriage
    puts 'Выберите поезд'
    display_trains_list(@trains)
    user_train = gets.strip
    if find_instance(@trains, user_train)
      train = find_instance(@trains, user_train)
      puts 'Введите номер вагона'
      user_сarriage = gets.to_i
      if train.carriages.any? && train.carriages[user_сarriage - 1]
        puts
        if train.type == 'Пассажирский'
          train.carriages[user_сarriage - 1].add_passenger
        else
          puts 'Введите объем груза'
          user_fill_volume = gets.to_f
          if user_fill_volume > 0
            train.carriages[user_сarriage - 1].fill_volume(user_fill_volume)
          end
          puts 'Не правильный объем груза' unless user_fill_volume > 0
        end
      else
        puts 'Такой вагон отсутствует' unless train.carriages[user_train - 1]
        puts 'В поезде отсутствуют вагоны' unless train.carriages.any?
      end
    else
      puts 'Указанный поезд не найден'
    end
  end

  def display_menu
    puts '=' * 40
    puts 'Доступны следующие операции:'
    puts '1 - Создать станцию'
    puts '2 - Создать поезд'
    puts '3 - Создать маршрут и управлять станциями'
    puts '4 - Назначить маршрут'
    puts '5 - Добавить вагоны'
    puts '6 - Отцепить вагоны'
    puts '7 - Переместить поезд'
    puts '8 - Посмотреть список станций'
    puts '9 - Посмотреть список поездов на станции'
    puts '10 - Посмотреть список вагонов поезда'
    puts '11 - Заполнить вагон'
    puts '0 - Выход'
    puts '=' * 40
  end

  def find_instance(array_of_instances, instance_name)
    array_of_instances.find { |object| object.name == instance_name }
  end
end
