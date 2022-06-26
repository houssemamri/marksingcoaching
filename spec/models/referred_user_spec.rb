require 'rails_helper'
require 'securerandom'

RSpec.describe ReferredUser, type: :model do
  it 'should error when saving without email' do
    expect do
      referred_user = ReferredUser.new
      referred_user.save!
    end.to raise_error(ActiveRecord::RecordInvalid)
  end

  it 'should error when saving with malformed email' do
    expect do
      ReferredUser.create!(email: 'notanemail')
    end.to raise_error(ActiveRecord::RecordInvalid)
  end

  it 'should generate a referral code on creation' do
    referred_user = ReferredUser.new(email: 'referred_user@example.com')
    referred_user.run_callbacks(:create)
    expect(referred_user).to receive(:create_referral_code)
    referred_user.save!
    expect(referred_user.referral_code).to_not be_nil
  end

  it 'should send a welcome email on save' do
    referred_user = ReferredUser.new(email: 'referred_user@example.com')
    referred_user.run_callbacks(:create)
    expect(referred_user).to receive(:send_welcome_email)
    referred_user.save!
  end

  describe 'self.unused_referral_code' do
    it 'should return the same referral code if there is no collision' do
      expect(ReferredUser).to receive(:find_by).and_return(nil)
      ReferredUser.unused_referral_code
    end

    it 'should return a new referral code if there is a collision' do
      expect(ReferredUser).to receive(:find_by)
        .exactly(2).times.and_return('collision', nil)
      ReferredUser.unused_referral_code
    end
  end
end
