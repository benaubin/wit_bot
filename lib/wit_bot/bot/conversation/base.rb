module WitBot
  module Bot
    module Conversation
      class Base
        include Observable

        def metadata
          thread.metadata
        end

        def thread
          @thread ||= MessageThread.new("#{self.class.name}-#{SecureRandom.uuid}")
        end

        def messages(user: true, bot: true)
          thread.messages_list user, bot
        end

        def send_message(text, sender=nil, meta=nil)
          sender && sender.bot? ? output(text, meta) : input(text, meta)
        end

        def input(input, meta=nil)
          message = thread.create_message input
          message.meta = meta
          message.send 1, false
          changed
          notify_observers :input, message
          message
        end

        def listen_with(listener_class)
          listener_class.new self
        end

        def output(text, meta=nil)
          message = thread.create_bot_message text
          message.meta = meta
          changed
          notify_observers :output, message
          message
        end

        def to_hash
          {
            thread: @thread
          }
        end

        def from_hash(json)
          @thread = WitBot::MessageThread.from_hash json[:thread]
          self
        end

        def self.from_hash(json)
          self.new.from_hash json.with_indifferent_access
        end
      end
    end
  end
end