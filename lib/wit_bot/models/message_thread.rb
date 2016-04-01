module WitBot
  class MessageThread
    attr_accessor :metadata

    attr_reader :id, :messages, :bot_messages

    def initialize(id=SecureRandom.uuid)
      @id = id
      @messages = ActiveSupport::OrderedHash.new
      @bot_messages = ActiveSupport::OrderedHash.new
      @metadata = nil
    end

    def message(id)
      messages[id]
    end

    def messages_list(user: true, bot: false)
      bot_messages = bot ? @bot_messages.values : []
      user_messages = user ? @messages.values : []
      user_messages + bot_messages
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

    def to_hash
      {
        id: @id,
        context: @context,
        messages: {
          bot: @bot_messages,
          user: @messages
        },
        metadata: @metadata
      }
    end

    def from_hash(json)
      m = json[:messages]
      @messages = WitBot::Message.many_from_hash(self, m[:user])
      @bot_messages = WitBot::Message.many_from_hash(self, m[:bot])

      @context = Context.from_hash json[:context] if json[:context]
      @metadata = json[:metadata]
      self
    end

    def self.from_hash(json)
      json = json.with_indifferent_access
      self.new(json[:id]).from_hash json
    end

    def ==(other)
      self.id == other.id &&
          self.context == other.context &&
          self.bot_messages == other.bot_messages &&
          self.messages == other.messages &&
          self.metadata == other.metadata
    end

    def equals_without_messages(other)
      self.id == other.id &&
          self.context == other.context &&
          self.metadata == other.metadata
    end
  end
end