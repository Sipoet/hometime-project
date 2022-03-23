class BaseAdapter

  def initialize(params)
    @params = params
  end

  def self.set_attribute(name, &block)
    temp_container = self.class_variable_defined?(:@@attributes) ? self.attributes : []
    temp_container << Attribute.new(name: name, converter: block)
    self.class_variable_set(:@@attributes, temp_container)
  end

  def self.attributes
    self.class_variable_get(:@@attributes) rescue []
  end

  def convert
    self.class.attributes.each_with_object({}) do|atribute, obj|
      obj[atribute.name] = atribute.converter.call(@params)
      Rails.logger.debug"Atribute #{atribute.name} value: #{obj[atribute.name]}"
    end
  end

  class Attribute
    attr_accessor :name, :converter

    def initialize(name:, converter:)
      @name = name
      @converter = converter
    end
  end
end