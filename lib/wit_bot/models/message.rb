module WitBot
  class Message
    attr_reader :thread, :text, :_text, :id, :sent, :_outcomes, :outcomes

    def initialize(thread=WitBot.thread, text, id: SecureRandom.uuid)
      @thread = thread
      @text = text
      @_text = nil
      @id = id
      @sent = false
      @outcomes = @_outcomes = nil
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
      message.thread.reset_context unless keep_context

      @_text = response['_text']
      @_outcomes = response['outcomes']
      @outcomes = @_outcomes.each_with_index.map { |outcome, i| Outcome.new self, outcome, i }

      self
    end

    def outcome
      outcomes.first
    end
  end
end