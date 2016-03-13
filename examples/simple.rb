#!/usr/bin/env ruby

require 'awesome_print'
require_relative '../lib/wit_bot'

WitBot.configure do |c|
  c.token = ENV['WIT_ACCESS_TOKEN'] # Create a wit bot and set the token here
end

message = WitBot.create_message 'This is a cool test'
message.send

outcome = message.outcome
ap outcome, {raw: true}