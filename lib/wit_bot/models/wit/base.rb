module WitBot
  module WitModel
    class Base
      attr_reader :id

      @@changeable_attrs = []
      @@changeable_attrs_only = {}
      @@server_attrs = []
      @@server_attrs_only = {}

      def initialize(id, request=false, *args)
        @id = id

        @delete_listeners = []

        get if request
      end

      class << self
        def all
          @all ||= REQUEST.new.get.map{|data| from_response_data data}
        end

        def get(model: nil)
          if model.respond_to? :get
            model.get
          else
            self.class.new id, request: true
          end
        end

        protected

        def changeable_attr(*attrs, only: nil)
          attr_accessor *attrs
          (only ? @@changeable_attrs : @@changeable_attrs_only[only] ||= []).concat attrs
        end

        def server_attr(*attrs, only: nil)
          attr_reader *attrs
          (only ? @@server_attrs : @@server_attrs_only[only] ||= []).concat attrs
        end
      end

      def create
        _response = request.create

        if self.respond_to? :process_create_response, true
          self.process_create_response(_response) do |response|
            from_response_data response
          end
        else
          from_response_data _response
        end
      end

      def delete
        request.delete

        @delete_listeners.all?{|listener| listener.call self}
      end

      def get(data: request.get(all: false))
        from_response_data data
      end

      def on_delete(&listener)
        @delete_listeners << listener
      end

      def to_h(include_id=true, method=caller[0])
        attrs = @@changeable_attrs + (@@changeable_attrs_only[method] || [])

        hash = {}
        hash[:id] = id if include_id

        attrs.inject(hash) do |h, v|
          h[v] = self.send v if self.send v
        end
      end
      alias :to_hash :to_h
      alias :as_json :to_h

      def from_response_data(response, method=caller[0])
        response = response.with_indifferent_access

        variables = (@@server_attrs_only[method] || []) + @@server_attrs + @@changeable_attrs

        variables.each do |attr|
          if (value = response[attr])
            processor = "process_#{attr}".to_sym

            value = self.send processor, value if self.respond_to? processor, true

            instance_variable_set "@#{attr}", value
          end
        end
      end
    end
  end
end