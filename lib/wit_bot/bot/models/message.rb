module WitBot
  module Bot
    class Message < WitBot::Message
      def bot?
        true
      end
      def from_hash(json)
        @_text = json[:_text]
        self
      end
      def self.from_hash(thread, id, json)
        self.new(thread, json[:text], id: id).from_hash json
      end
      def send
        throw "You can't send a bot message."
      end
    end
  end
end