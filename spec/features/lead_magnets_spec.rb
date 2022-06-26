require 'rails_helper'

describe 'LeadMagnets' do
  let(:user) { create :user }
  let!(:lead_magnet) { create :lead_magnet, can_be_used_to_build_a_list: true }

  before do
    sign_in user
    11.times { create :lead_magnet, can_be_used_to_build_a_list: true }
  end

  context 'access' do
    scenario 'marketplace shows lead_magnets' do
      visit marketplace_path
      LeadMagnet.all.each do |lead_magnet|
        expect(page).to have_content(lead_magnet.title)
      end
    end

    context 'show' do
      scenario 'with restrictions' do
        visit lead_magnet_path(lead_magnet.slug)
        expect(page).to have_button('Add To Cart')
      end

      scenario 'without restriction if has Payment' do
        payment = create :payment_for_main_offer, email: user.email, paid: true
        visit lead_magnet_path(lead_magnet.slug)
        expect(page).not_to have_button('Add To Cart')
        expect(page).to have_css('iframe')
      end

      scenario 'without restriction if has enough Referrals' do
        referrer = ReferredUser.create(email: user.email)
        4.times do
          ReferredUser.new(email: FFaker::Internet.email, referrer: referrer).save!
        end

        visit lead_magnet_path(lead_magnet.slug)
        expect(page).to have_button('Add To Cart')

        ReferredUser.new(email: FFaker::Internet.email, referrer: referrer).save!
        visit lead_magnet_path(lead_magnet.slug)
        expect(page).not_to have_button('Add To Cart')
        expect(page).to have_css('iframe')
      end
    end
  end

  context 'library' do
    # scenario 'has no lead magnets of their own' do
    #   visit library_path

    #   expect(page).to have_content('You have not added any of your own Lead Magnets.')

    #   click_on 'Add One Now'
    #   expect(page).to have_content('Add Your Lead Magnet')
    # end

    # scenario 'has lead magnets of their own' do
    #   own_lead_magnet = FactoryBot.create(:lead_magnet, user_id: user.id)
    #   visit library_path

    #   expect(page).not_to have_content('You have not added any of your own Lead Magnets.')
    #   expect(page).to have_content(own_lead_magnet.title)
    # end

    scenario 'has no lead magnets licensed' do
      visit library_path

      expect(page).to have_content('You have not licensed any of our Lead Magnets yet.')
      expect(page).not_to have_content(lead_magnet.title)
    end

    scenario 'has lead magnets licensed' do
      payment = create :payment_for_main_offer, email: user.email, paid: true
      visit library_path

      expect(page).not_to have_content('You have not licensed any of our Lead Magnets yet.')
      expect(page).to have_content(lead_magnet.title)
    end
  end
end
