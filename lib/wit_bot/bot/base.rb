module WitBot
  module Bot
    class Base < WitBot::Bot::Conversation::Participant
      def initialize(conversation)
        super conversation
      end

      class << self
        @@intents = []
        def intents(*args)
          if args.empty?
            @@intents.map! do |intent|
              if intent.is_a? WitBot::WitModel::Intent
                intent
              else
                WitBot::WitModel::Intent.find intent
              end
            end
          else
            @@intents.concat args
          end
        end
      end

      def intents
        self.class.intents
      end

      def intent_names
        intents.map { |intent| intent.name }
      end

      def on_input(message)
        outcome = message.outcome
        intent = outcome.intent
        intent_name = intent.name.to_sym

        if intent_names.include? intent_name
          method_name = "on_#{intent_name}".to_sym
          self.send method_name, message if self.respond_to? method_name, true
        end
      end
    end
  end
end