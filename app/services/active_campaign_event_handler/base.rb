module ActiveCampaignEventHandler
  class Base
    def self.add_contact_to_list(client, email, list)
      return unless Rails.env.production?

      client.contact_add(
        email: email,
        "p[#{list}]": list
      )
    end

    def self.fetch_lists_for(user)
      client = ::ActiveCampaign::Client.new(
        api_endpoint: user.active_campaign_url,
        api_key: user.active_campaign_api_key
      )
      # return unless Rails.env.production?

      client.list_list(ids: 'all')['results'].map do |list_hash|
        [list_hash['name'], list_hash['id']]
      end
    end
  end
end
