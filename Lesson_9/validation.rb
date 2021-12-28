module Validation
  module ClassMethods
    attr_reader :validations

    def validate(check_attr, validation_type, parameter = nil)
      @validations ||= []
      @validations.push({ attr_name: check_attr, type: validation_type, params: parameter })
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
        send(validation_name, validation[:attr_name], validation[:params])
      end
    end

    def validate_presence(attr_name, _params)
      raise ArgumentError, 'Presence validation fault' if attr_name.nil? || attr_name.empty?
    end

    def validate_format(attr_name, format)
      raise ArgumentError, 'Format validation fault' if attr_name !~ Regexp.new(format)
    end

    def validate_type(attr_name, attr_class)
      raise ArgumentError, 'Type validation fault' unless attr_name.is_a?(attr_class)
    end
  end
end
