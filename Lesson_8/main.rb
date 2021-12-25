require_relative './required_files'

class AppController
  def initialize
    @interface = MainInterface.new
  end

  def run
    @interface.run
  end

  def seed
    @interface.seed
  end
end
