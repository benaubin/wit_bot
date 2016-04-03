module WitBot
  module Generators
    class ModelGenerator < Rails::Generators::Base
      source_root File.expand_path('../templates', __FILE__)
      argument :user_model, type: :string, default: 'User'

      def create_conversations
        user_lower = user_model.underscore

        generate 'migration', 'CreateConversations', 'object:text'
        template 'model.rb.erb', 'app/models/conversation.rb'

        user_file = "app/models/#{user_lower}.rb"
        inject_into_class user_file, user_model, 'has_one :conversation, dependent: :destroy'
      end
    end
  end
end