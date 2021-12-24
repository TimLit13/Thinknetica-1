module Seed
  def seed

    add_seed_stations

    add_seed_routes

    add_seed_trains

    add_seed_carriages

    @train1.make_route(@route1)
    @train2.make_route(@route2)
  end

  private

  def add_seed_stations
    @station1 = Station.new('Spb')
    @stations.push(@station1)
    @station2 = Station.new('Viborg')
    @stations.push(@station2)
    @station3 = Station.new('Lahd')
    @stations.push(@station3)
    @station4 = Station.new('Sortavala')
    @stations.push(@station4)
  end

  def add_seed_routes
    @route1 = Route.new(@station1, @station4)
    @routes.push(@route1)
    @route1.add_station(@station2)
    @route1.add_station(@station3)

    @route2 = Route.new(@station4, @station1)
    @routes.push(@route2)
    @route2.add_station(@station2)
  end

  def add_seed_trains
    @train1 = PassengerTrain.new('111-11')
    @train2 = CargoTrain.new('222-22')
    @trains.push(@train1)
    @trains.push(@train2)
  end

  def add_seed_carriages
    5.times do
      @train1.add_carriage(PassengerCarriage.new(rand(36..54)))
    end

    50.times do
      @train2.add_carriage(CargoCarriage.new(rand(75.0..158.0)))
    end
  end
end
