module WitBot
  class Outcome
    attr_reader :message, :raw, :_text, :confidence, :intent, :entities

    def initialize(message, raw, i=0)
      @message = message
      @raw = raw.with_indifferent_access

      @confidence = @raw[:confidence]
      @_text = @raw[:_text]

      @intent = WitModel::Intent.find raw[:intent]
      @entities = EntityModelProxy.new raw[:entities]

      raise LowConfidenceError self if i == 0 && low_confidence?
    end

    def low_confidence?
      @confidence < WitBot.config.minimum_confidence
    end

    def ==(other)
      self.message == other.message &&
          self.raw == other.raw &&
          self._text == other._text &&
          self.confidence == other.confidence &&
          self.intent == other.intent &&
          self.entities == other.entities
    end
  end
end