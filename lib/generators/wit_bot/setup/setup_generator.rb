module WitBot
  module Generators
    class SetupGenerator < Rails::Generators::Base
      source_root File.expand_path('../templates', __FILE__)

      def create_initializer_file
        copy_file 'initializer.rb', 'config/initializers/wit_bot.rb'
      end
    end
  end
end