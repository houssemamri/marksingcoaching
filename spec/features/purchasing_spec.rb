require 'rails_helper'

describe 'Purchasing', :js do
  let(:user) { FactoryBot.create :user }
  let(:purchase_page) { library_pass_path }

  context "when one doesn't already have access" do
    scenario 'prompts user to purchase access' do
      visit purchase_page
      expect(page).to have_button 'COMPLETE ORDER NOW'
    end
  end

  context 'when one has purchased access' do
    let!(:payment) { FactoryBot.create :payment, email: user.email, paid: true }

    before do
      sign_in user
    end

    scenario 'shows button to dashboard' do
      visit purchase_page
      expect(page).to have_link 'Go to Dashboard'
    end
  end

  context 'Purchasing' do
    def fill_out_and_submit_purchase_form(email, select_oto = false)
      visit purchase_page
      fill_in(:payment_email, with: email)
      find('form #exclusive-offer').click if select_oto
      fill_stripe_elements(card: '4242 4242 4242 4242')
      click_on 'COMPLETE ORDER NOW'

      find('h1', text: 'Thank you!', wait: 10)
    end

    scenario 'main offer' do
      email = FFaker::Internet.email
      fill_out_and_submit_purchase_form(email)

      expect(page).to have_content 'Thank you!'
      expect(page).to have_content 'Set a password to access your new account'
    end

    scenario 'solicits sign_up' do
      email = FFaker::Internet.email
      fill_out_and_submit_purchase_form(email)

      expect(page).to have_css('form.new_user')
      expect(page).to have_content(email)
    end

    scenario 'allows sign_up' do
      email = FFaker::Internet.email
      fill_out_and_submit_purchase_form(email)

      fill_in(:user_password, with: 'password')
      within '#new_user' do
        click_on 'Sign up'
      end

      expect(page.current_path).to eq(dashboard_path)
      expect(page).to have_content 'Welcome! You have signed up successfully.'
    end

    scenario 'creates Payment' do
      email = FFaker::Internet.email
      fill_out_and_submit_purchase_form(email)

      payment = Payment.find_by(email: email)
      expect(payment.products).to eq ['Lead Magnets', 'Removed Branding']
      expect(payment.amount).to eq 9700
    end

    context 'opts in for OTO' do
      scenario 'creates Payment' do
        email = FFaker::Internet.email
        fill_out_and_submit_purchase_form(email, true)

        payment = Payment.find_by(email: email)
        expect(payment.products).to eq ['Lead Magnets', 'Social Media Courses', 'Removed Branding']
        expect(payment.amount).to eq 12600
      end
    end

    context 'opts into sign up OTO' do
      scenario 'creates Payment' do
        sign_in user

        visit '/sign-up-offer'

        fill_stripe_elements(card: '4242 4242 4242 4242')
        click_on 'COMPLETE ORDER NOW'
        find('h1', text: 'Thank you!', wait: 10)

        payment = Payment.find_by(email: user.email)
        expect(payment.products).to eq ['Lead Magnets', 'Removed Branding']
        expect(payment.amount).to eq 4700
      end
    end

    # context 'buys single lead_magnet' do
    #   scenario 'creates Payment' do
    #     lead_magnet = create :lead_magnet

    #     sign_in user

    #     visit "/lead_magnets/#{lead_magnet.slug}"
    #     click_on 'UNLOCK NOW'

    #     fill_stripe_elements(card: '4242 4242 4242 4242')
    #     click_on 'COMPLETE ORDER NOW'
    #     find('h1', text: 'Thank you!', wait: 10)

    #     payment = Payment.find_by(email: user.email)
    #     expect(payment.products).to eq ["LM-#{lead_magnet.id}"]
    #     expect(payment.amount).to eq 500
    #   end
    # end

    context 'purchases cart items' do
      scenario 'creates Payment' do
        lead_magnets = FactoryBot.create_list(:lead_magnet, 3)

        sign_in user

        lead_magnets.each do |lead_magnet|
          add_lead_magnet_to_cart(lead_magnet)
        end

        fill_stripe_elements(card: '4242 4242 4242 4242')
        click_on 'COMPLETE ORDER NOW'
        find('h1', text: 'Thank you!', wait: 10)

        payment = Payment.find_by(email: user.email)
        expect(payment.products).to eq(
          lead_magnets.map(&:payment_identifier)
        )
        expect(payment.amount).to eq 1500
      end
    end

    context 'purchases content idea generator' do
      scenario 'creates Payment' do
        sign_in user
        visit content_generator_buy_path

        fill_stripe_elements(card: '4242 4242 4242 4242')
        click_on 'COMPLETE ORDER NOW'
        find('h1', text: 'Thank you!', wait: 10)

        payment = Payment.find_by(email: user.email)
        expect(payment.products).to eq(
          ['Content Idea Generator']
        )
        expect(payment.amount).to eq 4700
      end
    end
  end
end
