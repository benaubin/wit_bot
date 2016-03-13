module WitBot
  class WitError < WitBotError
    attr_reader :status

    def initialize(status)
      @status = status
    end
  end
end