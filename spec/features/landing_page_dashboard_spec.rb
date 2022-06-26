# require 'rails_helper'

# describe 'Landing Page Dashboard', :js do
#   let(:user) { create :user }
#   let(:lead_magnet) { create :lead_magnet }

#   before do
#     sign_in user
#   end

#   context 'index' do
#     before do
#       visit landing_pages_path
#     end

#     context 'user has no landing pages' do
#       scenario 'displays message' do
#         expect(page).to have_content 'Landing Pages'
#         expect(page).to have_content 'You have not created any Landing Pages yet.'
#       end
#     end

#     context 'user has landing pages' do
#       let!(:landing_page) { create :landing_page, user: user, lead_magnet: lead_magnet }

#       scenario 'displays them' do
#         visit landing_pages_path
#         expect(page).to have_content 'Landing Pages'
#         expect(page).to have_content landing_page.name
#       end

#       scenario 'links to them' do
#         visit landing_pages_path
#         click_on landing_page.name
#         expect(page.current_path).to eq landing_page_path(landing_page)
#       end
#     end
#   end

#   context 'show' do
#     let(:landing_page) { create :landing_page, user: user, lead_magnet: lead_magnet }

#     before do
#       visit landing_page_path(landing_page)
#     end

#     scenario 'displays information' do
#       expect(page).to have_content landing_page.name
#     end
#   end
# end
