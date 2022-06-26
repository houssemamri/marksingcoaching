require 'rails_helper'

describe 'Sign Up Offer', :js do
  let(:user) { FactoryBot.create :user }

  context 'triggered on sign up' do
    before :each do
      email = FFaker::Internet.email
      visit new_user_registration_path
      fill_in(:user_email, with: email, match: :first)
      fill_in(:user_password, with: 'password', match: :first)
      find('.actions input').click
    end

    scenario 'has active offer' do
      expect(page).to have_content('Over 50% OFF The Library Pass!')
    end

    scenario 'has link to dashboard' do
      expect(page).to have_link('Click here to go to your dashboard.')
    end

    scenario 'prompts user to buy in dashboard' do
      visit '/dashboard'
      expect(page).to have_link('Get the Library Pass Now')
    end
  end

  context 'opting in' do
    scenario 'creates Payment' do
      email = FFaker::Internet.email
      visit new_user_registration_path
      fill_in(:user_email, with: email, match: :first)
      fill_in(:user_password, with: 'password', match: :first)
      find('.actions input').click

      fill_stripe_elements(card: '4242 4242 4242 4242')
      click_on 'COMPLETE ORDER NOW'
      find('h1', text: 'Thank you!', wait: 10)

      payment = Payment.find_by(email: email)
      expect(payment.products).to eq ['Lead Magnets', 'Removed Branding']
      expect(payment.amount).to eq 4700
    end
  end

  describe 'when not signed in' do
    it 'redirects to homepage' do
      visit '/sign-up-offer'
      expect(page).to have_content 'Log in'
    end
  end

  describe 'when offer expired' do
    let(:user) { FactoryBot.create :user, created_at: 10.days.ago }

    it 'redirects to homepage' do
      sign_in user
      visit '/sign-up-offer'
      expect(page).to have_content 'This offer has expired.'
    end

    scenario 'does not prompt user to buy in dashboard' do
      visit '/dashboard'
      expect(page).not_to have_link('Get the Library Pass Now')
    end
  end
end
