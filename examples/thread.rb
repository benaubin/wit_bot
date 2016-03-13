#!/usr/bin/env ruby

require 'awesome_print'
require 'wit_bot'

WitBot.configure do |c|
  c.token = ENV['WIT_ACCESS_TOKEN'] # Create a wit bot and set the token here
end

thread = WitBot.thread # Create a new thread

message = thread.create_message 'This is a cool test' # Create a normal message on the thread

message.send # Send that normal message

thread.context.state = 'how_cold' # Set the state to ask the user how cold the test really is.

message = thread.create_message '32 degrees' # Create a message on the thread

message.send # Send the message

outcome = message.outcome # Get the outcome

ap outcome, {raw: true} # Print the outcome