module WitBot
  class IntentMeta
    attr_reader :states

    def initialize(states: [])
      @states = states.map{ |state| State.find state }
    end

    def self.from_states(*states)
      self.new states: states
    end

    def to_h
      {states: states}
    end
    alias :to_hash :to_h
  end
end