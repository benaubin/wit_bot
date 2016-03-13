module WitBot
  class WitRequest
    def http
      WitBot.http
    end

    def request(request=http)
      if request.code.between? 200, 299
        request.parse.with_indifferent_access
      else
        response = request.parse.with_indifferent_access
        raise WitError.new(response[:status]), (response[:error] || response[:body])
      end
    end
  end
end