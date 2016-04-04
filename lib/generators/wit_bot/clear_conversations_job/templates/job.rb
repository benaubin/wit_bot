class ClearConversationsJob < ActiveJob::Base
  queue_as :low

  def perform
    # Find all conversations not updated in the last 4 hours, and destroy them.
    Conversation.where{ updated_at <= 4.hours.ago }.destroy_all
  end
end