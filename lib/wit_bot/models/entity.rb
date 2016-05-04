module WitBot
  class Entity
    attr_reader :id
    cattr_reader :entities
    alias_method :name, :id

    def initialize(id)
      @id = id
      @@entities = {@id => self}
    end

    def model(role, data)
      EntityModel.new self, role, data
    end

    class << self
      def self.find(name)
        @entities[name] || Entity.new(id: name)
      end
    end

    def ==(other)
      self.name == other.name
    end
  end
end