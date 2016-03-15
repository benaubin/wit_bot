module WitBot
  class MessageThread
    attr_accessor :metadata

    attr_reader :id, :messages, :bot_messages

    def initialize(id=SecureRandom.uuid)
      @id = id
      @messages = ActiveSupport::OrderedHash.new
      @bot_messages = ActiveSupport::OrderedHash.new
    end

    def message(id)
      messages[id]
    end

    def messages_list(user: true, bot: false)
      bot_messages = bot ? @bot_messages.values : []
      user_messages = user ? @messages.values : []
      bot_messages + user_messages
    end

    def create_message(text, id=SecureRandom.uuid)
      @messages[id] = WitBot::Message.new self, text, id: id
    end

    def create_bot_message(text, id=SecureRandom.uuid)
      @bot_messages[id] = WitBot::Bot::Message.new self, text, id: id
    end

    def context
      @context ||= Context.new
    end

    def reset_context
      @context = Context.new
    end
  end
end