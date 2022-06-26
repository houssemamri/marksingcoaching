require 'rails_helper'

describe 'Referral Tracker' do
  let!(:referrer_email) do
    FFaker::Internet.email
  end

  def referrer
    ReferredUser.find_by(email: referrer_email)
  end

  def progress_bars
    all('.progress-bar', visible: false)
  end

  def progress_bar_one_width
    "#{((progress_bars[0].style('width')['width'].to_f / progress_bars[0].find(:xpath, './/..').style('width')['width'].to_f) * 100).ceil.to_i}%"
  end

  def progress_bar_two_width
    "#{((progress_bars[1].style('width')['width'].to_f / progress_bars[1].find(:xpath, './/..').style('width')['width'].to_f) * 100).ceil.to_i}%"
  end

  before do
    ReferredUser.create(email: referrer_email)
    visit unlock_path
    fill_in(:referred_user_email, with: referrer_email)
    click_on 'UNLOCK'
  end

  scenario 'is allowed to re-instantiate session by entering email again' do
    Capybara.reset_sessions!
    visit unlock_path
    fill_in(:referred_user_email, with: referrer_email)
    click_on 'UNLOCK'
    expect(page).to have_content "You've invited 0 friends and 0 of them are confirmed."
  end

  context 'no referrals' do
    scenario 'indicates such', :js do
      expect(page).to have_content "You've invited 0 friends and 0 of them are confirmed."
      expect(progress_bar_one_width).to eq '0%'
      expect(progress_bar_two_width).to eq '0%'
    end
  end

  context '4 confirmed referrals and 1 unconfirmed referral' do
    before do
      4.times do
        ReferredUser.create(
          email: FFaker::Internet.email,
          referrer: referrer,
          confirmed: true
        )
      end
      ReferredUser.create(
        email: FFaker::Internet.email,
        referrer: referrer
      )
      visit unlock_path
    end

    scenario 'indicates such', :js do
      expect(page).to have_content "You've invited 5 friends and 4 of them are confirmed."
      expect(progress_bar_one_width).to eq '80%'
      expect(progress_bar_two_width).to eq '40%'
    end

    scenario 'is allowed to re-instantiate session by entering email again', :js do
      Capybara.reset_sessions!
      visit unlock_path
      fill_in(:referred_user_email, with: referrer_email)
      click_on 'UNLOCK'
      expect(page).to have_content "You've invited 5 friends and 4 of them are confirmed."
      expect(progress_bar_one_width).to eq '80%'
      expect(progress_bar_two_width).to eq '40%'
    end

    scenario 'shows that there is 1 referral left for lead magnet access' do
      expect(page).to have_content '1 left'
    end

    scenario 'shows that there is 1 referral left for social media courses access' do
      expect(page).to have_content '6 left'
    end
  end

  context '5 referrals and 2 unconfirmed referral' do
    before do
      5.times do
        ReferredUser.create(
          email: FFaker::Internet.email,
          referrer: referrer,
          confirmed: true
        )
      end
      2.times do
        ReferredUser.create(
          email: FFaker::Internet.email,
          referrer: referrer
        )
      end
      visit unlock_path
    end

    scenario 'indicates such', :js do
      expect(page).to have_content "You've invited 7 friends and 5 of them are confirmed."
      expect(progress_bar_one_width).to eq '100%'
      expect(progress_bar_two_width).to eq '50%'
    end

    scenario 'shows that there is 1 referral left for lead magnet access' do
      expect(page).to have_content "Congratulations! You've earned UNLIMITED ACCESS to ALL of our Lead Magnets FOR LIFE!"
    end

    scenario 'shows that there is 1 referral left for social media courses access' do
      expect(page).to have_content '5 left'
    end
  end

  context '11 referrals and 3 unconfirmed referral' do
    before do
      11.times do
        ReferredUser.create(
          email: FFaker::Internet.email,
          referrer: referrer,
          confirmed: true
        )
      end
      3.times do
        ReferredUser.create(
          email: FFaker::Internet.email,
          referrer: referrer
        )
      end
      visit unlock_path
    end

    scenario 'indicates such', :js do
      expect(page).to have_content "You've invited 14 friends and 11 of them are confirmed."
      expect(progress_bar_one_width).to eq '100%'
      expect(progress_bar_two_width).to eq '100%'
    end

    scenario 'shows that there is 1 referral left for lead magnet access', :js do
      expect(page).to have_content "Congratulations! You've earned UNLIMITED ACCESS to ALL of our Lead Magnets FOR LIFE!"
      expect(page).to have_content "Congratulations! You've earned UNLIMITED ACCESS to our Master Social Media Advertising Course Bundle FOR LIFE!"
    end

    scenario 'shows that there are no referrals left for access!' do
      expect(page).to have_content '0 left', count: 2
    end
  end
end
