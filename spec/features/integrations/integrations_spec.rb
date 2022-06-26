### PLEASE FIX THESE :(

# require 'rails_helper'

# describe 'Integrations', :js do
#   let(:user) { create :user }

#   before do
#     sign_in user
#   end

#   describe 'Active Campaign' do
#     let(:url) { 'www.activehosted.com' }
#     let(:api_key) { 'ac_key_12345' }

#     scenario 'can have credentials persisted' do
#       visit integrations_active_campaign_path
#       fill_in(:user_active_campaign_url, with: url)
#       fill_in(:user_active_campaign_api_key, with: api_key)
#       click_on 'Integrate'
#       expect(page).to have_content('Integration Successful')
#       user.reload
#       expect(user.active_campaign_url).to eq url
#       expect(user.active_campaign_api_key).to eq api_key
#     end
#   end

#   describe 'MailChimp' do
#     let(:api_key) { 'mc_key_12345' }

#     scenario 'can have credentials persisted' do
#       visit integrations_mailchimp_path
#       fill_in(:user_mailchimp_api_key, with: api_key)
#       click_on 'Integrate'
#       expect(page).to have_content('Integration Successful')
#       user.reload
#       expect(user.mailchimp_api_key).to eq api_key
#     end
#   end

#   describe 'Zapier' do
#     context 'is first time integrator' do
#       scenario 'does not have API Key' do
#         expect(user.zapier_api_key).to be nil
#       end

#       scenario 'gets API key on page load' do
#         visit '/integrations/zapier'
#         expect(page).to have_content user.zapier_api_key
#       end

#       scenario 'does not reset API key if already set by page load' do
#         test_key = 'zap_key_test'

#         user.zapier_api_key = test_key
#         user.save

#         visit '/integrations/zapier'

#         expect(page).to have_content test_key
#       end
#     end
#   end

#   describe 'LeadMagnet Integration page' do
#     let(:lead_magnet) { create :lead_magnet }

#     scenario 'does not have access to LeadMagnet' do
#       visit "/lead_magnet/#{lead_magnet.id}/integrations"
#       expect(page).to have_content 'You do not have access to this Lead Magnet.'
#     end

#     context 'has paid for access' do
#       before do
#         create :payment_for_main_offer, email: user.email, paid: true
#         visit "/lead_magnet/#{lead_magnet.id}/integrations"
#       end

#       context 'has set up no integrations' do
#         scenario 'says so and prompts to get one' do
#           expect(page).to have_content 'You have not set up any integrations...'
#           expect(page).to have_link 'Click here to do so!', href: integrations_path
#         end
#       end

#       # context 'has set up ActiveCampaign integration' do
#       #   before do
#       #     user.active_campaign_api_key = 'ac_123'
#       #     user.active_campaign_url = 'ac.com'
#       #     user.save
#       #     visit "/lm/lead_magnet/#{lead_magnet.id}/integrations"
#       #   end

#       #   xscenario 'displays IntegrationRule form' do
#       #     expect(page).to have_content 'Active Campaign'
#       #   end
#       # end

#       # context 'has set up Mailchimp integration' do
#       #   before do
#       #     user.mailchimp_api_key = 'ac_123'
#       #     user.save
#       #     visit "/lm/lead_magnet/#{lead_magnet.id}/integrations"
#       #   end

#       #   xscenario 'displays IntegrationRule form' do
#       #     expect(page).to have_content 'MailChimp'
#       #   end
#       # end
#     end
#   end
# end
