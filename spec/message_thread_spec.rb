require_relative 'helpers/helper'

RSpec.describe WitBot::MessageThread do
  before :all do
    @thread_id = "test_thread_#{SecureRandom.uuid}"
  end
  before :each do
    @message_thread = WitBot::MessageThread.new @thread_id
  end

  describe '#new' do
    it 'automatically picks an id' do
      thread = WitBot::MessageThread.new
      expect(thread.id).not_to eq(nil)
    end
    it 'can be created with an id' do
      thread = WitBot::MessageThread.new @thread_id
      expect(thread.id).to be(@thread_id)
    end
  end

  describe '#create_message' do
    it 'creates a message on the thread from text' do
      message = @message_thread.create_message 'This is a cool test.'

      expect(message.thread).to be(@message_thread)
      expect(@message_thread.messages_list).to include(message)
    end
  end

  describe '#messages_list' do
    before :each do
      @message = @message_thread.create_message 'This is a cool test.'
      @bot_message = @message_thread.create_bot_message 'That is a cool test.'
    end

    it "doesn't return bot messages by default" do
      list = @message_thread.messages_list

      expect(list).to include(@message)
      expect(list).not_to include(@bot_message)
      expect(list).to eq(@message_thread.messages.values)
    end

    it 'returns bot and human messages when (bot: true)' do
      list = @message_thread.messages_list bot: true

      expect(list).to eq(@message_thread.messages_list(user: true, bot: true))
      expect(list).to include(@message)
      expect(list).to include(@bot_message)
      expect(list).to eq(@message_thread.messages.values + @message_thread.bot_messages.values)
    end

    it 'returns only bot messages when (bot: true, user: false)' do
      list = @message_thread.messages_list bot: true, user: false

      expect(list).not_to include(@message)
      expect(list).to include(@bot_message)
      expect(list).to eq(@message_thread.bot_messages.values)
    end

    it 'returns an empty array when (user: false)' do
      list = @message_thread.messages_list user: false

      expect(list).to eq(@message_thread.messages_list(user: false, bot: false))
      expect(list.length).to eq(0)
    end
  end

  describe '#to_hash' do
    it 'can be converted to a hash' do
      expect(@message_thread.to_hash).to be_a(Hash)
    end
  end
  describe 'self#from_hash' do
    before :each do
      @m1 = @message_thread.create_message 'This is a cool test.'
      @message_thread.create_bot_message 'That is a cool test.'
      @m2 = @message_thread.create_message 'This is a cool pool.'
      @message_thread.create_bot_message 'That is a cool pool.'
    end

    it 'can be recreated from a hash' do
      hash = @message_thread.as_json

      new = WitBot::MessageThread.from_hash hash

      expect(new.messages).to eq(@message_thread.messages)
    end

    it 'can be recreated from a hash with sent messages' do
      @m1.send
      @m2.send

      hash = @message_thread.as_json

      new = WitBot::MessageThread.from_hash hash

      expect(new.messages).to eq(@message_thread.messages)
    end
  end
end