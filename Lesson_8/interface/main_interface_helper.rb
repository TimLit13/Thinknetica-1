module MainInterfaceHelper

  private

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
  
  def user_choice_mistake(user_choice)
    puts "Программа не распознала команду #{user_choice}."
  end

  def display_route_menu
    puts 'Выберите действие:'
    puts '1 - Создать маршрут'
    puts '2 - Добавить станцию в маршрут'
    puts '3 - Удалить станцию из маршрута'
  end
end