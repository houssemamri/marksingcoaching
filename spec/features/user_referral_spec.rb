require 'rails_helper'

describe 'User Referral' do
  let(:referral_page) { unlock_path }

  it 'renders unlock page on first visit' do
    visit referral_page
    expect(page).to have_field(:referred_user_email)
  end

  context 'when one is a referrer' do
    let(:email) { FFaker::Internet.email }
    let(:new_email) { FFaker::Internet.email }

    before do
      visit referral_page
      fill_in(:referred_user_email, with: email)
      click_on 'UNLOCK'
      visit referral_page
    end

    scenario 'redirects to /refer-a-friend' do
      # visit referral_page
      expect(page).not_to have_field(:referred_user_email)
    end

    scenario 'shows referral code' do
      referral_code = ReferredUser.find_by(email: email).referral_code
      expect(page).to have_content(referral_code)
      # Capybara.reset_sessions!
    end

    scenario 'new users are registered for referrer' do
      Capybara.reset_sessions!

      referrer = ReferredUser.find_by(email: email)
      visit "/unlock?ref=#{referrer.referral_code}"
      fill_in(:referred_user_email, with: new_email)
      click_on 'UNLOCK'
      referrer.reload

      referrer = ReferredUser.find_by(email: email)
      expect(referrer.referrals.count).to be 1
      expect(referrer.referrals.first.email).to eq new_email
    end

    context 'confirmation' do
      scenario 'is not confirmed by default' do
        referrer = ReferredUser.find_by(email: email)
        expect(referrer.confirmed?).to be false
        expect(page).to have_content('Confirmation email sent to your inbox.')
      end

      scenario 'is confirmed upon visiting link' do
        referrer = ReferredUser.find_by(email: email)
        visit "/referrer/#{referrer.id}"
        referrer.reload
        expect(referrer.confirmed?).to be true
        expect(page).not_to have_content('Confirmation email sent to your inbox.')
      end
    end
  end
end
