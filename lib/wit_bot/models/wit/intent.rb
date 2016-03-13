module WitBot
  module WitModel
    class Intent < Base
      changeable_attr :name, :doc, :metadata
      changeable_attr :expressions, :meta, only: :create
      server_attr :id, :expressions

      @@intents = {}

      def initialize(id, doc: nil, metadata: nil, expressions: [], states: [], meta: {states: []}, request: false)
        super

        @name = id
        @doc = doc
        @metadata = metadata

        meta[:states].concat states

        @expressions = process_expressions expressions
        @meta = process_meta meta

        @@intents[@name] = self
      end

      def self.find(name)
        @@intents[name] || self.new(name, request: true)
      end

      protected

      def process_expressions(expressions)
        IntentExpressions.new self, expressions
      end

      def process_meta(meta)
        IntentMeta.new **meta.symbolize_keys
      end

      def process_create_response(response)
        response.each{ |r| yield r }
      end

      def request
        IntentsRequest.new(model: self)
      end

      def self.request
        IntentsRequest.new
      end
    end
  end
end