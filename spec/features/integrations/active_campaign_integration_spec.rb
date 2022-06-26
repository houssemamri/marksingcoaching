# require 'rails_helper'

# describe 'Active Campaign notifications' do
#   context 'in production', :js do
#     context 'user signs up' do
#       let(:user) { FactoryBot.build :user }

#       before do
#         visit root_path
#         fill_in(:user_email, with: user.email)
#         fill_in(:user_password, with: 'password')
#       end

#       scenario 'is added to User:Free Account in Active Campaign' do
#         expect(
#           ActiveCampaignEventHandler::InternalEventAPI
#         ).to receive(:user_signed_up).with(user.email)
#         click_on 'Sign up'
#       end
#     end

#     context 'user buys library pass' do
#       let(:user) { FactoryBot.create :user }

#       before do
#         sign_in user
#         visit library_pass_path
#         fill_stripe_elements(card: '4242 4242 4242 4242')
#       end

#       scenario 'is added to Buyer:Library Pass in Active Campaign' do
#         expect(
#           ActiveCampaignEventHandler::InternalEventAPI
#         ).to receive(:bought_library_pass).with(user.email)
#         click_on 'COMPLETE ORDER NOW'
#         expect(page).to have_content 'Thank you!'
#       end
#     end
#   end
# end
