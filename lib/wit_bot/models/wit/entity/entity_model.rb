module WitBot
  class EntityModel
    attr_accessor :others
    attr_reader :entity, :role, :raw, :value

    def initialize(entity, role, raw)
      @entity = entity
      @role = role
      @raw = raw.with_indifferent_access

      @value = case @raw[:type].to_sym
               when :value
                 @raw[:value].to_s
               else
                 @raw[:value]
               end

      @others = []
    end

    def to_s
      value.to_s
    end
  end
end