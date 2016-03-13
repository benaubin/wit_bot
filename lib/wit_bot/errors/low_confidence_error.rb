module WitBot
  class LowConfidenceError < WitBotError
    attr_reader :outcome, :message, :confidence, :minimum_confidence

    def initialize(outcome, minimum_confidence=config.minimum_confidence)
      @outcome = outcome
      @message = outcome.message
      @confidence = outcome.confidence
      @minimum_confidence = minimum_confidence
    end

    def to_s
      "Confidence (#{confidence}) is lower then the minimum (#{minimum_confidence})"
    end
  end
end