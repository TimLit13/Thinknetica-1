module Seed
  def seed
    station_1 = Station.new('Spb')
    @stations.push(station_1)
    station_2 = Station.new('Viborg')
    @stations.push(station_2)
    station_3 = Station.new('Lahd')
    @stations.push(station_3)
    station_4 = Station.new('Sortavala')
    @stations.push(station_4)

    route_1 = Route.new(station_1, station_4)
    @routes.push(route_1)
    route_1.add_station(station_2)
    route_1.add_station(station_3)

    route_2 = Route.new(station_4, station_1)
    @routes.push(route_2)
    route_2.add_station(station_2)

    train_1 = PassengerTrain.new('111-11')
    train_2 = CargoTrain.new('222-22')
    @trains.push(train_1)
    @trains.push(train_2)

    5.times do
      train_1.add_carriage(PassengerCarriage.new(rand(36..54)))
    end

    50.times do
      train_2.add_carriage(CargoCarriage.new(rand(75.0..158.0)))
    end

    train_1.set_route(route_1)
    train_2.set_route(route_2)
  end
end
