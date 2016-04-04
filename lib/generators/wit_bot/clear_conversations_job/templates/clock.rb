require 'clockwork'

require_relative 'config/boot'
require_relative 'config/environment'

module Clockwork
  every(1.hour, 'Clear Old Conversations') { ClearConversationsJob.perform_later }
end