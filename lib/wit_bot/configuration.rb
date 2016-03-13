class Configuration
  attr_accessor :token, :host, :minimum_confidence, :version
  def initialize
    @token = nil
    @host = 'https://api.wit.ai'
    @minimum_confidence = 0
    @version = "20160313"
  end
end