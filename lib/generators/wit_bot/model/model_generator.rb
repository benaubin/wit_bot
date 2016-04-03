module WitBot
  module Generators
    class ModelGenerator < Rails::Generators::Base
      source_root File.expand_path('../templates', __FILE__)
      argument :user_model, type: :string, default: 'User'
      hook_for :force, type: :boolean

      def create_conversations
        user_lower = user_model.underscore

        migration_options = 'migration', 'CreateConversations', 'object:text', "#{user_lower}:references"
        migration_options << '--force' if options[:force]

        generate *migration_options
        template 'model.rb.erb', 'app/models/conversation.rb'

        user_file = "app/models/#{user_lower}.rb"
        inject_into_class user_file, user_model, "  has_one :conversation, dependent: :destroy\n"

        readme 'clear_conversations.txt'
      end
    end
  end
end