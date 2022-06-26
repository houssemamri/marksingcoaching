require 'rails_helper'
require 'securerandom'

def generate_email
  FFaker::Internet.email
end

describe 'Referred User' do
  describe 'new' do
    before(:each) do
      @referral_code = SecureRandom.hex(5)
    end

    it 'renders new referred_user/landing page on first visit' do
      get unlock_path
      expect(response).to have_http_status(:success)
    end

    it 'skips first page on saved referred_user\'s second visit' do
      cookies[:h_email] = generate_email
      expect(ReferredUser).to receive(:find_by_email).with(cookies[:h_email]) do
        ReferredUser.new
      end

      get unlock_path
      expect(response).to redirect_to '/refer-a-friend'
    end

    it 'assigns referral code to cookie if code belongs to referred_user' do
      expect(ReferredUser).to receive(:find_by).with(referral_code: @referral_code) do
        ReferredUser.new
      end

      get unlock_path, params: { ref: @referral_code }
      expect(cookies[:h_ref]).to eq(@referral_code)
    end

    it 'continues request when referred_user agent is facebookexternalhit/1.1' do
      Rails.application.env_config['HTTP_USER_AGENT'] = 'facebookexternalhit/1.1'

      get unlock_path, params: { ref: @referral_code }
      assert_response :success
    end

    xit 'redirects to intended url when referred_user agent is not facebookexternalhit/1.1' do
      Rails.application.env_config['HTTP_USER_AGENT'] = 'notfacebookexternalhit'

      get unlock_path, params: { ref: @referral_code }
      expect(response).to redirect_to root_path
    end
  end

  describe 'refer' do
    it 'should redirect to landing page if there is no email in cookie' do
      get refer_a_friend_path
      expect(response).to redirect_to unlock_path
    end

    it 'should render /refer-a-friend page if known email exists in cookie' do
      cookies[:h_email] = generate_email
      expect(ReferredUser).to receive(:find_by_email) { ReferredUser.new }

      get refer_a_friend_path
      assert_response :success
    end
  end

  describe 'saving users' do
    before(:each) do
      @email = generate_email
    end

    it 'redirects to /refer-a-friend on creation' do
      post referred_users_path, params: { referred_user: { email: @email } }
      expect(response).to redirect_to '/refer-a-friend'
    end

    it 'has a referrer when referred' do
      referrer_email = "#{SecureRandom.hex}@example.com"
      referrer = ReferredUser.create(email: referrer_email)
      cookies[:h_ref] = referrer.referral_code

      post referred_users_path, params: { referred_user: { email: @email } }
      referred_user = @controller.view_assigns['referred_user']

      expect(cookies[:h_email]).to eq(referred_user.email)
      expect(referred_user.referrer.email).to eq(referrer.email)
    end

    it 'does not have a referrer when signing up unreferred' do
      post referred_users_path, params: { referred_user: { email: @email } }
      referred_user = @controller.view_assigns['referred_user']
      expect(referred_user.referrer).to be_nil
    end

    context 'ip addresses' do
      before(:each) do
        @ip_address = "192.0.2.#{SecureRandom.hex(3)}"
        Rails.application.env_config['HTTP_X_FORWARDED_FOR'] = @ip_address
        post referred_users_path, params: { referred_user: { email: @email } }
        @saved_ip = IpAddress.find_by_address @ip_address
      end

      it 'creates a new IpAddress on new email submission' do
        expect(@saved_ip).to_not be_nil
        expect(@saved_ip.count).to eq(1)
        expect(@saved_ip.address).to eq(@ip_address)
      end

      it 'increases the count of the IpAddress when then address appears again with same email' do
        post referred_users_path, params: { referred_user: { email: @email } }

        updated_ip = IpAddress.find_by_address @ip_address
        expect(updated_ip).to_not be_nil
        expect(updated_ip.count).to eq(2)
      end

      it 'increases the count of the IpAddress when then address appears again with different email' do
        post referred_users_path, params: { referred_user: { email: generate_email } }

        updated_ip = IpAddress.find_by_address @ip_address
        expect(updated_ip.count).to eq(2)
      end

      it 'redirects to /refer-a-friend if the ip count is less than 3' do
        post referred_users_path, params: { referred_user: { email: generate_email } }
        expect(response).to redirect_to '/refer-a-friend'
      end

      it 'redirects to landing page when ip has already appeared 3 times' do
        post referred_users_path, params: { referred_user: { email: generate_email } }
        post referred_users_path, params: { referred_user: { email: generate_email } }
        post referred_users_path, params: { referred_user: { email: generate_email } } # 4th time

        expect(response).to redirect_to unlock_path
      end

      xit 'redirects to landing page when resubmitting from different ips' do
        new_address = "192.0.2.#{SecureRandom.hex(3)}"
        Rails.application.env_config['HTTP_X_FORWARDED_FOR'] = new_address
        post referred_users_path, params: { referred_user: { email: @email } }
        expect(response).to redirect_to unlock_path
      end
    end

    # probably should do more than redirect, but this is current behavior
    it 'redirects to main page when malformed email is submitted' do
      post referred_users_path, params: { referred_user: { email: 'notanemail' } }
      expect(response).to redirect_to unlock_path
    end
  end
end
