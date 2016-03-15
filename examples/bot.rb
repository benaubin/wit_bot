#require 'wit_bot'

require_relative '../lib/wit_bot'

require_relative 'bot/bot'

WitBot.configure do |c|
  c.token = ENV['WIT_ACCESS_TOKEN'] # Create a wit bot and set the token here
end

conversation = WitBot::Bot::Conversation::Base.new

bot = Bot.new conversation

loop do
  print 'Input: '
  conversation.send_message gets.chomp
end