require_relative 'helpers/helper'

RSpec.describe WitBot::Message do
  before :all do
    WitBot.configure do |c|
      c.token = ENV['WIT_ACCESS_TOKEN']
    end

    @message_thread = WitBot.thread
    @message_text = 'This is a cool test.'
    @message = WitBot::Message.new @message_thread, @message_text
    @message.send
  end

  before :each do
    @outcome = @message.outcome.clone
  end

  after :all do
    WitBot.reset
  end

  describe '#entities' do
    it 'should return a entity model proxy' do
      expect(@outcome.entities).to be_a(WitBot::EntityModelProxy)
    end
  end
end