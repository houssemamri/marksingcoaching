module MailchimpEventHandler
  class Base
    def self.add_contact_to_list(client, email, list); end

    def self.fetch_lists_for(user)
      response = request_instance(user.mailchimp_api_key).lists.retrieve
      response.body['lists'].map do |list_hash|
        [list_hash['name'], list_hash['id']]
      end
    end

    def self.request_instance(api_key)
      Gibbon::Request.new(api_key: api_key)
    end
  end
end
