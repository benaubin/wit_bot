module WitBot
  module Generators
    class MessageBusGenerator < Rails::Generators::Base
      source_root File.expand_path('../templates', __FILE__)
      argument :user_model, type: :string, default: 'User'
      argument :bot_name, type: string, required: true
      argument :bot_channel, type: string, default: '/witbot'

      def install_dependencies
        gem 'message_bus', '~> 2.0.0.beta.5'
      end

      def create_message_bus_listener
        user_lower = user_model.underscore
        template 'message_bus_listener.rb.erb', 'app/wit_bot/message_bus_listener.rb'
      end

      def create_message_bus_controller
        user_lower = user_model.underscore
        template 'message_bus_controller.rb.erb', 'app/controllers/message_bus_controller.rb'
      end

      def create_job
        user_lower = user_model.underscore
        template 'job.rb.erb', 'app/jobs/message_bus_job.rb'
      end
    end
  end
end