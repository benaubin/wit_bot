require_relative 'helpers/helper'

RSpec.describe WitBot::State do
  describe '#new' do
    it 'creates a new state' do
      state = WitBot::State.new(:state)
      expect(state).to be_a(WitBot::State)
      expect(state.state).to eq(:state)
    end
  end
  describe 'self#find' do
    it 'can find or create a state from a symbol' do
      state = WitBot::State.find :testing

      expect(WitBot::State.find(:testing)).to be(state)
    end
  end
  describe 'self#all' do
    it 'returns all states defined' do
      testing_state = WitBot::State.find :testing
      foo_state = WitBot::State.find :foo

      expect(WitBot::State.all).to include(foo_state, testing_state)
    end
  end
end