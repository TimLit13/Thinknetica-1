module InstanceCounter
  def self.included(any_class)
    any_class.extend ClassMethods
    # any_class.send :include, InstanceMethods
    any_class.include InstanceMethods
    # переменная экземпляра класса на уровне класса
    # инициализируется при подмешивании модуля в класс

    # присвоить значение ноль таким образом не получится,
    # так как присваиваетсятолько при подключении (когда included)
    # соответственно у потомков класса она не инициализируется (nil)..
    # any_class.instances = 0
  end

  module ClassMethods
    # доступ к переменной экземпляра класса на уровне класса
    attr_writer :instances

    def instances
      @instances ||= 0
    end
  end

  module InstanceMethods
    # protected так как у класса в который подкючается модуль
    # могут быть наследники

    protected

    def register_instance
      # self.class.instances = 0 if self.class.instances.nil?
      self.class.instances += 1
    end
  end
end
