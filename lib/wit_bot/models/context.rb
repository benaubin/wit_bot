module WitBot
  class Context
    attr_accessor :state, :reference_time, :entities, :location
    attr_writer :hash

    def empty?
      as_json.empty?
    end

    def as_json
      h = {}
      h[:state] = state if state
      h[:reference_time] = reference_time.iso8601 if reference_time
      h[:entities] = entities.each{|i| i.to_h} if entities
      h[:location] = location if location
      h
    end
  end
end