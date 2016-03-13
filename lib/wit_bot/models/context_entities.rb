module WitBot
  class ContextEntities
    def initialize
      @hash = {}
    end
    def [](entity)
      @hash[entity]
    end
    def []=(entity, value, expressions=[value])
      @hash[entity] = value.is_a?(EntityValue) ? value : EntityValue.new(value, expressions)
    end
    def as_json
      @hash.map do |id, values|
        {id: id, values: values}
      end
    end
  end
end