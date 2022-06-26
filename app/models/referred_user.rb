class ReferredUser < ApplicationRecord
  belongs_to :referrer, class_name: 'ReferredUser', foreign_key: 'referrer_id'
  has_many :referrals, class_name: 'ReferredUser', foreign_key: 'referrer_id'

  validates :email, presence: true, uniqueness: true, format: {
    # with: /\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*/i,
    with: /\A[^@\s]+@[^@\s]+\z/,
    message: 'Invalid email format.'
  }
  validates :referral_code, uniqueness: true

  before_create :create_referral_code
  after_create :send_welcome_email

  def self.unused_referral_code
    referral_code = SecureRandom.hex(5)
    collision = ReferredUser.find_by(referral_code: referral_code)

    until collision.nil?
      referral_code = SecureRandom.hex(5)
      collision = ReferredUser.find_by(referral_code: referral_code)
    end
    referral_code
  end

  def send_welcome_email
    SendGridEmailer.new.send_referral_welcome_email_to(self)
  end

  def referral_url
    "#{ENV['HOST_URL']}unlock?ref=#{referral_code}"
  end

  def referrer_url
    "#{ENV['HOST_URL']}referrer/#{id}"
  end

  private

  def create_referral_code
    self.referral_code = self.class.unused_referral_code
  end
end
