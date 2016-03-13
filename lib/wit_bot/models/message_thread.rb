module WitBot
  class MessageThread
    attr_reader :id, :messages

    def initialize(id=SecureRandom.uuid)
      @id = id
      @messages = {}
    end

    def message(id)
      messages[id]
    end

    def messages_list
      messages.values
    end

    def create_message(text, id=SecureRandom.uuid)
      WitBot::Message.new self, text, id: id
    end

    def context
      @context ||= Context.new
    end

    def reset_context
      @context = Context.new
    end
  end
end