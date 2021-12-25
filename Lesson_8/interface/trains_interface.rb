class TrainsInterface
  include FindInstance
  
  attr_accessor :trains

  def initialize
    @trains = []
  end

  def index
    puts '-' * 40
    puts 'Список поездов:'
    @trains.each_with_index do |train, i|
      puts "#{i + 1} #{train.name}"
    end
    puts '-' * 40
  end

  def create
    attempts = 0
    begin
      puts 'Введите тип поезда:'
      user_train_type = gets.strip
      puts 'Введите номер поезда:'
      user_train_name = gets.strip
      case user_train_type
      when 'Пассажирский'
        @trains.push(PassengerTrain.new(user_train_name))
      when 'Грузовой'
        @trains.push(CargoTrain.new(user_train_name))
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
    puts "#{user_train_type} поезд ##{user_train_name} успешно создан" if attempts < 3
  end

  def add_route(routes_interface)
    puts 'Введите номер поезда для добавления маршрута'
    user_train = gets.strip
    train = find_instance(@trains, user_train) if find_instance(@trains,
                                                                user_train)
    if train.nil?
      puts 'Такой поезд отсутствует'
    else
      routes_interface.index
      puts 'Выберите маршрут'
      user_route = gets.to_i

      if routes_interface.routes[user_route - 1]
        train.make_route(routes_interface.routes[user_route - 1])
        routes_interface.routes[user_route - 1].stations.first.train_arrive(train)
      else
        puts 'Введен неправильный маршрут'
      end
    end
  end

  def add_carriage
    attempts = 0
    puts 'Выберите поезд'
    index
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
    index
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
    index
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

  def display_carriages_list
    puts 'Выберите поезд'
    index
    user_train = gets.strip
    if find_instance(@trains, user_train)
      train = find_instance(@trains, user_train)
      if train.carriages.any?
        l = -> (carriage, index) do
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
    index
    user_train = gets.strip
    if find_instance(@trains, user_train)
      train = find_instance(@trains, user_train)
      puts 'Введите номер вагона'
      user_carriage = gets.to_i
      if train.carriages.any? && train.carriages[user_carriage - 1]
        case train.type
        when 'Пассажирский'
          train.carriages[user_carriage - 1].add_passenger
        when 'Грузовой'
          puts 'Введите объем груза'
          user_fill_volume = gets.to_f
          train.carriages[user_carriage - 1].fill_volume(user_fill_volume) if user_fill_volume.positive?
          puts 'Не правильный объем груза' unless user_fill_volume.positive?
        end
      else
        puts 'Такой вагон отсутствует' unless train.carriages[user_carriage - 1]
        puts 'В поезде отсутствуют вагоны' unless train.carriages.any?
      end
    else
      puts 'Указанный поезд не найден'
    end
  end

end