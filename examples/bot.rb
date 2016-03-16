require_relative 'helpers/helpers'
require_relative 'bot/bot'

conversation = WitBot::Bot::Conversation::Base.new

bot = Bot.new conversation

loop do
  print 'Input: '
  conversation.send_message gets.chomp
end