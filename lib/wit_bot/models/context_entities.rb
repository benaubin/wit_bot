module WitBot
  class ContextEntities
    attr_reader :id
    attr_accessor :values

    def initialize
      @hash = {}
    end
    def [](entity)
      @hash[entity]
    end
    def []=(entity, value, expressions=[value])
      @hash[entity] = value.is_a?(EntityValue) ? value : EntityValue.new(value, expressions)
    end
    def to_hash
      @hash.map do |id, values|
        {id: id, values: values}
      end
    end
    def from_hash(json)
      json.each do |object|
        self[object[:id]] = EntityValue.new object[:values]
      end
      self
    end
    def self.from_hash(json)
      self.new.from_hash json
    end

    def ==(other)
      self.id == other.id && self.values == other.values
    end
  end
end