require 'active_support/core_ext/hash/indifferent_access'
require 'active_support/core_ext/module/attribute_accessors'
require 'active_support/ordered_hash'
require 'active_support/concern'
require 'http'
require 'require_all'
require 'observer'

module WitBot
  class << self
    # @return [Configuration]
    def configuration
      @configuration ||= Configuration.new
    end
    alias :config :configuration

    def request_sender
      @request_sender ||= WitRequestSender.new
    end

    def reset_request_sender
      @request_sender.close
      @request_sender = WitRequestSender.new
    end

    def reset
      @configuration = Configuration.new
    end

    def configure
      yield configuration
    end

    def http
      request_sender.http
    end

    def thread
      MessageThread.new
    end

    def create_message(text)
      thread.create_message text
    end

    def load
      warn_level = $VERBOSE
      $VERBOSE = nil
      result = load_rel 'wit_bot'
      $VERBOSE = warn_level
      result
    end
  end
end

WitBot.load