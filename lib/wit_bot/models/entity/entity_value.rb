module WitBot
  class EntityValue
    attr_accessor :value, :expressions

    def initialize(value, expressions=[value])
      if value.is_a? Hash
        hash = value.with_indifferent_access
        @value = hash[:value]
        @expressions = hash[:expressions]
      else
        @value = value
        @expressions = expressions
      end
    end

    def to_h
      {value: value, expressions: expressions}
    end
    alias :to_hash :to_h
  end
end