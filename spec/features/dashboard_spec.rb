require 'rails_helper'

describe 'Dashboard' do
  let(:user) { FactoryBot.create :user }

  before do
    sign_in user
  end

  context 'sidebar' do
    before do
      visit dashboard_path
    end

    scenario 'has link to /library' do
      expect(page).to have_link 'Library', href: library_path
    end

    scenario 'shows link to /leads' do
      expect(page).to have_link 'Leads', href: leads_path
    end

    scenario 'has link to /integrations' do
      expect(page).to have_link 'Integrations', href: integrations_path
    end

    scenario 'has link to /users/edit' do
      expect(page).to have_link 'Settings', href: '/users/edit'
    end
  end

  context '"First Win" Checklist' do
    context 'User has No access to Lead Magnets' do
      scenario 'shows unchecked box for item "Pick a Lead Magnet"' do
        visit dashboard_path
        within('#first-win-checklist #item-1') do
          expect(page).to have_css('.octicon.octicon-circle')
        end
      end
    end

    context 'User has access to Lead Magnets' do
      before do
        FactoryBot.create :payment_for_main_offer, email: user.email
        visit dashboard_path
      end

      scenario 'shows checked box for item "Pick a Lead Magnet"' do
        within('#first-win-checklist #item-1') do
          expect(page).to have_css('.octicon.octicon-check-circle')
        end
      end

      context 'User has No Leads' do
        scenario 'shows unchecked box for item "Collect a Lead"' do
          within('#first-win-checklist #item-2') do
            expect(page).to have_css('.octicon.octicon-circle')
          end
        end

        scenario 'shows unchecked box for item "Profit"' do
          within('#first-win-checklist #item-3') do
            expect(page).to have_css('.octicon.octicon-circle')
          end
        end
      end

      context 'User has Leads' do
        before do
          FactoryBot.create :lead, user: user
          visit dashboard_path
        end

        scenario 'shows checked box for item "Collect a Lead"' do
          within('#first-win-checklist #item-2') do
            expect(page).to have_css('.octicon.octicon-check-circle')
          end
        end

        scenario 'shows checked box for item "Profit"' do
          within('#first-win-checklist #item-3') do
            expect(page).to have_css('.octicon.octicon-check-circle')
          end
        end
      end
    end
  end
end
