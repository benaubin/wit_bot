module WitBot
  module Bot
    class Message < WitBot::Message
      def bot?
        true
      end
      def send
        throw "You can't send a bot message."
      end
    end
  end
end