#!/usr/bin/env ruby

require 'awesome_print'
require 'wit_bot'

WitBot.configure do |c|
  c.token = ENV['WIT_ACCESS_TOKEN'] # Create a wit bot and set the token here
end

thread = WitBot.thread

message = thread.create_message 'This is a cool test'

message.send

thread.context.state = 'how_cold'

message = thread.create_message '32 degrees'

message

message.send

outcome = message.outcome

ap outcome, {raw: true}