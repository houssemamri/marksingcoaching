module ActiveCampaignEventHandler
  class InternalEventAPI < Base
    LISTS = {
      USER_SIGNED_UP: { ID: '3' },
      BUYER_LIBRARY_PASS: { ID: '4' }
    }.freeze

    def self.user_signed_up(user_email)
      # add_contact_to_list(
      #   client,
      #   user_email,
      #   LISTS[:USER_SIGNED_UP][:ID]
      # )
    end

    def self.bought_library_pass(user_email)
      # add_contact_to_list(
      #   client,
      #   user_email,
      #   LISTS[:BUYER_LIBRARY_PASS][:ID]
      # )
    end

    def self.client
      ::ActiveCampaign::Client.new(
        api_endpoint: ENV['ACTIVE_CAMPAIGN_URL'],
        api_key: ENV['ACTIVE_CAMPAIGN_KEY']
      )
    end
  end
end
