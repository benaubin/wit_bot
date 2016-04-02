module WitBot
  class EntityModelProxy < HashWithIndifferentAccess
    attr_reader :raw

    def initialize(raw_entities)
      @raw = raw_entities

      super Hash[*raw_entities.map do |(role, all)|
        all = all.map { |data| WitModel::Entity.find(data[:entity], create: false).model role, data }

        data = all.first

        data.all = all

        create_getter role

        [role, data]
      end.flatten]
    end

    def method_missing(*_)
      nil
    end

    private
    def create_getter(var)
      self.class.send(:define_method, var, -> { self[var] })
    end
  end
  class EntityModel
    attr_accessor :all
    attr_reader :entity, :role, :raw, :value

    def initialize(entity, role, raw)
      @entity = entity
      @role = role
      @raw = raw.with_indifferent_access

      @value = case @raw[:type] && @raw[:type].to_sym
               when :value
                 @raw[:value].to_s
               else
                 @raw[:value]
               end

      @others = []
    end

    def others
      all - [self]
    end

    def ==(other)
      self.entity == other.entity && self.value == other.value
    end

    def to_s
      value.to_s
    end
  end
end