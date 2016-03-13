module WitBot
  class WitRequestSender

    def initialize
      @http = HTTP[
                    Accept: "application/vnd.wit.#{WitBot.config.version}+json",
                    Authorization: "Bearer #{WitBot.config.token}"
                  ]
                  .persistent(WitBot.config.host)
    end
    def http
      @http
    end
    def close
      @http.close
    end
  end
end