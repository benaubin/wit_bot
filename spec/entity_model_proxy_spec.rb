require_relative 'helpers/helper'

RSpec.describe WitBot::EntityModelProxy do
  before :all do
    WitBot.configure do |c|
      c.token = ENV['WIT_ACCESS_TOKEN']
    end

    @message_thread = WitBot.thread
    @message_text = 'This is a cool test.'
    @message = @message_thread.create_message @message_text
    @message.send
    @outcome = @message.outcome
  end

  after :all do
    WitBot.reset
  end

  before :each do
    @entities = @outcome.entities.clone
  end

  describe '#{value}' do
    context 'with more then one' do
      it 'should return a list' do
        expect(@entities.word).to be_an(Array)
      end
    end
    context 'with only one' do
      it 'should return an entity model' do
        expect(@entities.adjective).to be_an(WitBot::EntityModel)
      end
    end
  end
  describe '#{not_a_value}' do
    it 'should not raise an error' do
      expect{ @entities.not_a_value }.not_to raise_error
    end
    it 'should return nil' do
      expect(@entities.not_a_value).to be(nil)
    end
  end
end