module WitBot
  class IntentExpressions < Array
    def initialize(intent, *expressions)
      @intent = intent
      super expressions.flatten!.map{|i| Expression.new @intent, i}
    end

    def create(body, request: true)
      self << Expression.new(@intent, body, request: request)
    end
  end
end