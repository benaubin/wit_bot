require 'helpers/helper'

RSpec.describe WitBot::Configuration do
  before :each do
    @config = WitBot::Configuration.new
  end

  it 'has defaults' do
    expect(@config.host).to eq('https://api.wit.ai')
    expect(@config.minimum_confidence).to eq(0)
    expect(@config.version).to eq('20160313')
  end
  it 'can be set' do
    fake_token = 'not a real token'

    @config.token = fake_token
    expect(@config.token).to eq(fake_token)
  end
end