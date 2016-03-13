module WitBot
  class WitRequest
    def http
      WitBot.http
    end

    def request(request=http)
      if request.code.between? 200, 299
        process_response request.parse
      else
        response = request.parse.with_indifferent_access
        raise WitError.new(response[:status]), (response[:error] || response[:body])
      end
    end

    private
    def process_response(response)
      if response.respond_to? :with_indifferent_access
        response.with_indifferent_access
      elsif response.respond_to? :map
        response.map {|r| process_response r}
      else
        response
      end
    end
  end
end