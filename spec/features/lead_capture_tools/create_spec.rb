require 'rails_helper'

describe 'Lead Capture Tool Creation' do
  let(:user) { create :user }
  let(:lead_magnet) { create :lead_magnet, can_be_used_to_build_a_list: true }

  before do
    sign_in user
  end

  context 'when user does not have access to lead magnet' do
    scenario 'can it add to cart' do
      visit lead_magnet_path(lead_magnet)

      expect(page).to have_button('Add To Cart')
    end
  end

  context 'when user has access to lead magnet' do
    scenario 'can create a lead capture tool' do
      payment = create :payment_for_main_offer, email: user.email, paid: true
      visit lead_magnet_path(lead_magnet)
      fill_in('Name', with: 'Tool Name')
      select('Widget', from: 'Type')
      click_on('Start Collecting Leads >')

      expect(page).to have_content('Lead Capture Tool created successfully! 😁')
    end
  end
end
