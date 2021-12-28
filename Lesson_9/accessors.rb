module Accessors
  module ClassMethods
    def attr_accessor_with_history(*names)
      names.each do |name|
        var_name = "@#{name}".to_sym
        var_name_history = "@#{name}_history".to_sym
        # getters
        define_method(name) { instance_variable_get(var_name) }
        define_method("#{name}_history") { instance_variable_get(var_name_history) }
        # setter
        define_method("#{name}=") do |value|
          instance_variable_set(var_name, value)
          instance_variable_set(var_name_history, instance_variable_get(var_name_history).to_a.push(value))
        end
      end
    end

    def strong_attr_accessor(attr_name, class_name)
      var_name = "@#{attr_name}".to_sym
      # getter
      define_method(attr_name) { instance_variable_get(var_name) }
      # setter
      define_method("#{attr_name}=") do |value|
        if value.is_a?(class_name) # value.instance_of?(class_name)
          instance_variable_set(var_name, value)
        else
          raise(ArgumentError, 'Incorrect value or class type')
        end
      end
    end
  end
end
