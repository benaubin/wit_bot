module WitBot
  class Message
    attr_reader :thread, :text, :_text, :id, :sent, :_outcomes, :outcomes

    attr_accessor :meta

    def initialize(thread=WitBot.thread, text, id: SecureRandom.uuid)
      @thread = thread
      @text = text
      @_text = nil
      @id = id
      @sent = false
      @outcomes = @_outcomes = nil
    end

    def bot?
      false
    end

    def to_hash
      {
        text: @text,
        _text: @_text,
        id: @id,
        bot: bot?,
        sent: @sent,
        _outcomes: @_outcomes
      }
    end

    def from_hash(json)
      @_text = json[:_text]
      @sent = json[:sent]
      @_outcomes = json[:_outcomes]
      parse_outcomes!
      self
    end
    def self.from_hash(thread, id, json)
      json = json.with_indifferent_access
      return Bot::Message.from_hash thread, id, json if json[:bot]
      self.new(thread, json[:text], id: id).from_hash json
    end
    def self.many_from_hash(thread, json)
      json.inject({}) { |h, (id, message)| h[id] = self.from_hash thread, id, message; h }
    end

    def params(p=nil)
      params = {
        q: text,
        msg_id: id,
        thread_id: thread.id
      }
      params[:context] = JSON.dump thread.context.as_json unless thread.context.empty?
      p ? params.merge(p) : params
    end

    def send(n=1, keep_context=true)
      response = MessageRequest.new.request(self, n)

      @sent = true
      thread.reset_context unless keep_context

      @_text = response['_text']
      @_outcomes = response['outcomes']

      parse_outcomes!

      self
    end

    def parse_outcomes(outcomes=@_outcomes)
      outcomes.each_with_index.map { |outcome, i| Outcome.new self, outcome, i } if outcomes
    end

    def parse_outcomes!(outcomes=@_outcomes)
      @outcomes = parse_outcomes outcomes
    end

    def outcome
      outcomes.first
    end

    def ==(other)
      self.text == other.text &&
          self._text == other._text &&
          self.id == other.id &&
          self.bot? == other.bot? &&
          self.sent == other.sent &&
          self._outcomes == other._outcomes &&
          self.thread.equals_without_messages(other.thread) &&
          self.outcomes == other.outcomes
    end
  end
end