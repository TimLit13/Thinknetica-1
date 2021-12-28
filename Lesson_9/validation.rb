module Validation
  def self.included(any_class)
    any_class.extend ClassMethods
    any_class.include InstanceMethods
  end

  module ClassMethods
    attr_reader :validations

    def validate(check_attr, validation_type, parameter = nil)
      @validations ||= []
      @validations.push({ attr_name: check_attr, type: validation_type, params: parameter })
      puts @validations
    end
  end

  module InstanceMethods
    def valid?
      validate!
    rescue ArgumentError => e
      puts e.message
      false
    end

    private

    def validate!
      self.class.validations.each do |validation|
        validation_name = "validate_#{validation[:type]}".to_sym
        attr_variable = instance_variable_get("@#{validation[:attr_name]}")
        send(validation_name, attr_variable, validation[:params])
      end
    end

    def validate_presence(attr_name, _params)
      # puts "validate_presence"
      # puts attr_name
      # puts _params
      raise ArgumentError, 'Presence validation fault' if attr_name.nil? || attr_name.empty?
    end

    def validate_format(attr_name, format)
    #   puts "validate_format"
    #   puts attr_name
    #   puts format
      raise ArgumentError, 'Format validation fault' if attr_name !~ Regexp.new(format)
    end

    def validate_type(attr_name, attr_class)
      # puts "validate_type"
      # puts attr_name
      # puts attr_class
      raise ArgumentError, 'Type validation fault' unless attr_name.is_a?(attr_class)
    end
  end
end
