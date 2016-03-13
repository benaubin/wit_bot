module WitBot
  class State
    cattr_reader :states
    attr_reader :state

    @@states = {}

    def initialize(state)
      @state = state
    end

    def self.find(state)
      @@states[state] ||= State.new(state)
    end

    def self.all
      @@states.values
    end

    alias :to_s :state
    alias :as_json :state
  end
end