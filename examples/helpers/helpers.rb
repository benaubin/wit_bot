require_relative '../../lib/wit_bot'
require 'ap'

WitBot.configure do |c|
  c.token = ENV['WIT_ACCESS_TOKEN'] # Create a wit bot and set the token here
end