class CargoCarriage < Carriage

  attr_reader :filled_volume

  def initialize(max_cargo_volume)
    @max_cargo_volume = max_cargo_volume.to_f
    @filled_volume = 0.0
    @type = 'Грузовой'
    validate!
  end

  def fill_volume(volume)
    ((@filled_volume + volume) < @max_cargo_volume) ? @filled_volume += volume : (puts "Слишком большой объем груза")
  end

  def available_volume
    @max_cargo_volume - @filled_volume
  end

  private

  attr_reader :max_cargo_volume

  def validate!
    raise RuntimeError, "Введен недопустимый объем вагона" unless @max_cargo_volume.between?(0.0,160.0)
  end
end