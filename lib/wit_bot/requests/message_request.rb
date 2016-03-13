module WitBot
  class MessageRequest < WitRequest
    def request(message, n)
      super http.get '/message', params: message.params(n: n)
    end
  end
end