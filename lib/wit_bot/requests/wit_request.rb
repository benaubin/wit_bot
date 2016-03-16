module WitBot
  class WitRequest
    def http
      WitBot.http
    end

    def request(request=http)
      response = process_response request.parse
      if request.code.between? 200, 299
        response
      else
        raise WitError.new(response[:status]), (response[:error] || response[:body])
      end
    end

    private
    def process_response(response)
      if response.respond_to? :with_indifferent_access
        response.with_indifferent_access
      elsif response.is_a? Array
        response.map {|r| process_response r}
      else
        response
      end
    end
  end
end