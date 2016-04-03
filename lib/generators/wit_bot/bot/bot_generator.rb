module WitBot
  module Generators
    class BotGenerator < Rails::Generators::NamedBase
      source_root File.expand_path('../templates', __FILE__)
      argument :intents, type: :array, default: nil

      def create_bot
        template 'bot.rb.erb', "app/wit_bot/#{file_name}_bot.rb"
      end
    end
  end
end