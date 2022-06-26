class Payment < ApplicationRecord
  belongs_to :user
  before_save { email.downcase! }

  after_create :register_with_active_campaign

  def register_with_active_campaign
    ActiveCampaignEventHandler::InternalEventAPI.bought_library_pass(email) if products.include? 'Lead Magnets'
  end
end
