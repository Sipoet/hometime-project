class BaseAdapter

  def initialize(params)
    @params = params
  end

  def self.set_attribute(name, &block)
    temp_container = self.class_variable_defined?(:@@attributes) ? self.attributes : []
    atribute = Attribute.new(name)
    block.call(atribute)
    temp_container << atribute
    self.class_variable_set(:@@attributes, temp_container)
  end

  def self.attributes
    self.class_variable_get(:@@attributes) rescue []
  end

  def convert
    self.class.attributes.each_with_object({}) do|atribute, obj|
      obj[atribute.name] = get_value(atribute)
      Rails.logger.debug"Atribute #{atribute.name} value: #{obj[atribute.name]}"
    end
  end

  private

  def get_value(atribute)
    atribute.converters.each do |converter|
      value = converter.call(@params) rescue nil
      return value if value.present?
    end
  end

  class Attribute
    attr_accessor :name
    attr_reader :converters

    def initialize(name)
      @name = name
      @converters = []
    end

    def add_converter(&block)
      @converters << block
    end
  end
end