# require 'rails_helper'

# describe 'Landing Pages', :js do
#   let(:user) { create :user }
#   let(:lead_magnet) { create :lead_magnet }

#   def visit_lead_magnet_page
#     visit lead_magnet_path(lead_magnet.slug)
#   end

#   before do
#     create :payment_for_main_offer, email: user.email
#     sign_in user
#   end

#   context 'navigating to create new landing page' do
#     # THIS SPEC IS WACK.
#     scenario 'from lead_magnet page' do
#       visit_lead_magnet_page
#       click_on 'Landing Page'

#       # find('a', text: 'Build Custom Landing Page', wait: 10)
#       # click_on 'Build Custom Landing Page'

#       # find('#new_landing_page', wait: 10)
#       # expect(page).to have_field :landing_page_headline
#       expect(page).to have_css(
#         "a[href='#{lead_magnet_landing_pages_new_path(lead_magnet)}']",
#         text: 'Build Custom Landing Page'
#       )
#     end
#   end

#   context 'creation' do
#     scenario 'from lead_magnet page' do
#       visit_lead_magnet_page
#       click_on 'Landing Page'
#     end
#   end
# end
