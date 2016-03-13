module WitBot
  class State
    cattr_reader :states
    attr_reader :state

    @@states = {}

    def initialize(state)
      @state = state
      @@states[state] = self
    end

    def self.find(state)
      @@states[state] || State.new(state)
    end

    alias :to_s :state
    alias :as_json :state
  end
end