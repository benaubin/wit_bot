require_relative 'helpers/helper'

RSpec.describe WitBot do
  describe '#create_message' do
    it 'creates a message with given text' do
      message_text = 'This is a cool test.'
      message = WitBot.create_message message_text

      expect(message).to be_a(WitBot::Message)
      expect(message.text).to eq(message_text)
    end
  end
  describe '#thread' do
    it 'creates a message thread' do
      expect(WitBot.thread).to be_a(WitBot::MessageThread)
    end
  end
  describe '#load' do
    it 'reloads WitBot' do
      expect { WitBot.load }.not_to raise_error
    end
  end
  describe '#reset' do
    it 'resets the configuration' do
      config = WitBot.config.dup
      WitBot.reset
      expect(WitBot.config).not_to be(config)
    end
  end
  describe '#configure' do
    it 'can configure WitBot' do
      test_token = 'not_a_real_token'
      test_host = 'test_host'
      minimum_confidence = 0.5
      version = '0'

      WitBot.configure do |c|
        c.token = test_token
        c.host = test_host
        c.minimum_confidence = minimum_confidence
        c.version = version
      end

      expect(WitBot.config.token).to eq(test_token)
      expect(WitBot.config.host).to eq(test_host)
      expect(WitBot.config.minimum_confidence).to eq(minimum_confidence)
      expect(WitBot.config.version).to eq(version)
    end
    it 'yields a block with WitBot#configuration' do
      expect{ |b| WitBot.configure &b }.to yield_with_args(WitBot.configuration)
    end
  end
end