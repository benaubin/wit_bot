require_relative 'helpers/helper'

RSpec.describe WitBot::Message do

  before :all do
    WitBot.configure do |c|
      c.token = ENV['WIT_ACCESS_TOKEN']
    end

    @message_thread = WitBot.thread
    @message_text = 'This is a cool test.'
  end

  before :each do
    @message = WitBot::Message.new @message_thread, @message_text
  end

  after :all do
    WitBot.reset
  end

  describe '#new' do
    it 'can be created with text' do
      message = WitBot::Message.new @message_text

      expect(message.text).to eq(@message_text)
    end
    it 'can be created with a thread' do
      message = WitBot::Message.new @message_thread, @message_text

      expect(message.text).to eq(@message_text)
      expect(message.thread).to be(@message_thread)
    end
    it 'can be created with an id' do
      id = 'not a good id'

      message = WitBot::Message.new @message_text, id: id

      expect(message.text).to eq(@message_text)
      expect(message.id).to eq(id)
    end
    it 'can be created with an id and thread' do
      id = 'not a good id'
      message = WitBot::Message.new @message_thread, @message_text, id: id

      expect(message.text).to eq(@message_text)
      expect(message.thread).to be(@message_thread)
      expect(message.id).to eq(id)
    end
  end

  describe '#send' do
    it 'returns itself' do
      expect(@message.send).to be(@message)
    end
    it 'can be sent' do
      expect(@message.send).to eq(@message)
      expect(@message.outcome).to be(@message.outcomes.first)
      expect(@message.outcome).to be_a(WitBot::Outcome)
    end
  end

  describe '#to_hash' do
    it 'can be serialized to a hash' do
      expect(@message.to_hash).to be_a(Hash)
    end
  end

  describe 'self#from_hash' do
    it 'can be created from a hash' do
      thread = WitBot.thread
      id = 'fake_id'
      text = 'This is a cool test.'

      message = WitBot::Message.new thread, text, id: id

      hash = message.to_hash

      new = WitBot::Message.from_hash thread, id, hash

      expect(new.text).to eq(message.text)
      expect(new.id).to eq(message.id)
      expect(new.thread).to eq(message.thread)
    end
    it 'can be created from a hash of a sent message' do
      thread = WitBot.thread
      id = 'fake_id'
      text = 'This is a cool test.'

      message = WitBot::Message.new thread, text, id: id
      message.send
      hash = message.to_hash

      new = WitBot::Message.from_hash thread, id, hash

      expect(new._outcomes).to eq(message._outcomes)
    end
  end
end