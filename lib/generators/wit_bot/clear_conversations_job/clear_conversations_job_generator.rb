module WitBot
  module Generators
    class ClearConversationsJobGenerator < Rails::Generators::Base
      source_root File.expand_path('../templates', __FILE__)

      def create_job
        gem 'clockwork', '~> 1.2.0'

        template 'clock.rb', 'clock.rb'
        template 'clear_conversations_job.rb', 'app/jobs/clear_conversations_job.rb'
      end
    end
  end
end