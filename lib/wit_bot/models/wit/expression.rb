module WitBot
  class Expression
    attr_accessor :intent, :body

    def initialize(intent, body, request: false)
      @intent = intent
      @body = body.is_a?(Hash) ? body.with_indifferent_access[:body] : body
      create if request
    end

    def create
      request.create
      intent.get
    end

    def delete
      request.delete
      intent.get
    end

    def to_h
      {body: body}
    end
    alias :as_json :to_h

    protected
    def request
      ExpressionsRequest.new model: self
    end
  end
end