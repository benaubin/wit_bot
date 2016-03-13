module WitBot
  class ExpressionsRequest < WitModelRequest
    def model_path
      "/intents/#{@model.intent.name}/expressions"
    end
  end
end