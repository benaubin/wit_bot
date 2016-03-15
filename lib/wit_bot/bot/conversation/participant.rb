module WitBot
  module Bot
    module Conversation
      class Participant
        attr_reader :conversation

        def initialize(conversation)
          @conversation = conversation
          @conversation.add_observer self
        end
        def bot?
          true
        end
        def output(text)
          @conversation.send_message text, self
        end
        def update(type, message)
          case type
            when :input
              self.on_input message if self.respond_to? :on_input, true
            when :output
              self.on_output message if self.respond_to? :on_output, true
          end
        end
      end
    end
  end
end