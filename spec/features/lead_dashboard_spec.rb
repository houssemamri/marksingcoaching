require 'rails_helper'

describe 'Leads Dashboard' do
  let(:user) { create :user }
  let(:lead_magnet) { create :lead_magnet }

  context 'index' do
    before do
      sign_in user
    end

    scenario 'no leads' do
      visit leads_path
      expect(page).to have_content 'You have not collected any leads yet'
      expect(page).to have_link 'See All Lead Magnets', href: marketplace_path
    end

    scenario 'shows leads' do
      6.times do
        create :lead, user: user, lead_magnet: lead_magnet
      end

      visit leads_path

      expect(page).not_to have_content 'You have not collected any leads yet'
      expect(page).to have_css('tbody tr', count: 6)
      user.leads.each do |lead|
        expect(page).to have_content lead.email
      end
    end
  end
end
