module WitBot
  module WitModel
    class Entity < Base
      changeable_attr :doc, :values
      server_attr :uuid, :builtin, :id
      server_attr :lang, :closed, :exotic, only: :create

      alias_method :name, :id

      @@entities = {}

      def initialize(id, doc=false, values=nil, request: false)
        super
        @doc = doc
        @values = values
        @uuid = nil

        @@entities[name] = self
      end

      def model(role, data)
        EntityModel.new self, role, data
      end

      def self.find(name, create=true)
        @@entities[name] || create && Entity.new(id: name, request: true)
      end

      protected

      def process_values(values)
        values.map{|v| EntityValue.new v}
      end

      def request
        EntitiesRequest.new(model: self)
      end
    end
  end
end