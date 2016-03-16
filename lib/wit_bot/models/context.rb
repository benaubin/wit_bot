module WitBot
  class Context
    attr_accessor :reference_time, :location
    attr_writer :hash, :entities, :state

    def state
      @state ||= []
    end

    def empty?
      to_hash.empty?
    end

    def entities
      @entities ||= ContextEntities.new
    end

    def to_hash
      h = {}
      h[:state] = state if state && !state.empty?
      h[:reference_time] = reference_time.iso8601 if reference_time
      h[:entities] = entities if @entities
      h[:location] = location if location
      h
    end

    def from_hash(h)
      @state = Array.wrap h[:state]
      @reference_time = Date.parse h[:reference_time] if h[:reference_time]
      @entities = ContextEntities.from_hash h[:entities] if h[:entities]
      @location = h[:location]
      self
    end
    def self.from_hash(json)
      self.new.from_hash json
    end
  end
end