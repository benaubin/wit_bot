module WitBot
  class WitModelRequest < WitRequest
    attr_reader :model

    def model_path; end

    def individual_model_path
      "#{model_path}/#{@model.name || @model.id}"
    end

    def initialize(model: nil)
      @model = model
    end

    def get(all: true)
      path = all ? model_path : individual_model_path
      request http.get path
    end

    def create
      request http.post(model_path, json: model.as_json)
    end

    def update
      request http.put(model_path, json: model.as_json)
    end

    def delete
      request http.delete("#{model_path}/#{model.name}")
    end
  end
end