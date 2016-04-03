module WitBot
  module Generators
    class MessageBusGenerator < Rails::Generators::Base
      source_root File.expand_path('../templates', __FILE__)
      argument :bot_name, type: :string, required: true
      argument :user_model, type: :string, default: 'User'
      argument :bot_channel, type: :string, default: '/witbot'

      def install_dependencies
        gem 'redis', '~> 3'
        gem 'message_bus', '~> 2.0.0.beta.5'
        Bundler.with_clean_env do
          run 'bundle install'
        end
      end

      def create_message_bus_listener
        template 'message_bus_listener.rb.erb', 'app/wit_bot/message_bus_listener.rb'
      end

      def create_message_bus_controller
        template 'message_bus_controller.rb.erb', 'app/controllers/message_bus_controller.rb'
      end

      def create_job
        template 'job.rb.erb', 'app/jobs/message_bus_job.rb'
      end

      private
      def user_lower
        user_model.underscore
      end
    end
  end
end