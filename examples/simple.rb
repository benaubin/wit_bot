#!/usr/bin/env ruby

lib = File.expand_path('../../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'awesome_print'
require 'wit_bot'

WitBot.configure do |c|
  c.token = ENV['WIT_ACCESS_TOKEN'] # Create a wit bot and set the token here
end

message = WitBot.create_message 'This is a cool test' # Create a message.
message.send # Send it.

outcome = message.outcome # Get the outcome
ap outcome, {raw: true} # Print it.