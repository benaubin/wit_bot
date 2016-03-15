module WitBot
  class Context
    attr_accessor :reference_time, :location
    attr_writer :hash, :entities, :state

    def state
      @state ||= []
    end

    def empty?
      as_json.empty?
    end

    def entities
      @entities ||= ContextEntities.new
    end

    def as_json
      h = {}
      h[:state] = state if state && !state.empty?
      h[:reference_time] = reference_time.iso8601 if reference_time
      h[:entities] = entities if @entities
      h[:location] = location if location
      h
    end
  end
end