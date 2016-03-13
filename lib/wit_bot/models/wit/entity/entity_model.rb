module WitBot
  class EntityModel
    attr_accessor :others
    attr_reader :entity, :role, :raw

    def initialize(entity, role, raw)
      @entity = entity
      @role = role
      @raw = raw.with_indifferent_access

      @value = case @raw[:type].to_sym
               when :value

               else
                 @raw[:value]
               end

      @others = []
    end
  end
end