class MainInterface
  include FindInstance
  include MainInterfaceHelper
  include Seed

  def initialize
    @stations_interface = StationsInterface.new
    @trains_interface = TrainsInterface.new
    @routes_interface = RoutesInterface.new
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
        make_route
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
    @stations_interface.create
  end

  def create_train
    @trains_interface.create
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
    else
      user_choice_mistake(user_choice)
    end
  end

  def create_new_route
    @stations_interface.index
    @routes_interface.create(@stations_interface)
  end

  def add_station_to_route
    @routes_interface.update(@stations_interface)
  end

  def remove_station_from_route
    @routes_interface.destroy(@stations_interface)
  end

  def make_route
    @trains_interface.index
    @trains_interface.add_route(@routes_interface)
  end

  def add_carriage
    @trains_interface.add_carriage
  end

  def remove_carriage
    @trains_interface.remove_carriage
  end

  def move_train
    @trains_interface.move_train
  end

  def display_stations_list
    @stations_interface.index
  end

  def display_trains_on_station
    @stations_interface.display_trains_on_station
  end

  def display_carriages_list
    @trains_interface.display_carriages_list
  end

  def fill_carriage
    @trains_interface.fill_carriage
  end
end
