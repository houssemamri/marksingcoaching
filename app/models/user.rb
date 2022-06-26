class User < ApplicationRecord
  include OmniauthAttributesConcern

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable
  #  , omniauth_providers: [:stripe_connect]

  has_many :user_authentications

  has_many :content_gen_survey_answers
  has_many :lead_magnets
  has_many :lead_capture_tools
  has_many :leads, through: :lead_capture_tools
  has_many :checklists
  has_many :favorites
  has_many :ebooks, as: :favoritable
  has_one :cart

  after_create :register_with_active_campaign

  def self.create_from_omniauth(params)
    name = params['info']['name']
    email = params['info']['email']
    create!(
      name: name,
      email: email,
      password: SecureRandom.hex(10)
    )
    # self.send(params.provider, params)
  end

  def fetch_cart
    cart || create_cart
  end

  def has_purchased_lead_magnets?
    Payment.where(email: email).count.positive?
  end

  def purchased_lead_magnets
    products = Payment.where(email: email).pluck(:products).flatten
    if products.include? 'Lead Magnets'
      LeadMagnet.where(can_be_used_to_build_a_list: true)
    else
      # IF THIS IS NOT FOUND IS BUG
      ebook_ids = products.map { |p| p.match(/LM-(.+)/) }.map { |md| md[1] }
      LeadMagnet.where(id: ebook_ids)
    end
  end

  def register_with_active_campaign
    ActiveCampaignEventHandler::InternalEventAPI.user_signed_up(email)
  end

  def integrated_with_zapier?
    zapier_api_key.present?
  end

  def integrated_with_mailchimp?
    mailchimp_api_key.present?
  end

  def integrated_with_active_campaign?
    active_campaign_api_key.present? && active_campaign_url.present?
  end

  def get_active_campaign_lists
    ActiveCampaignEventHandler::Base.fetch_lists_for(self)
  end

  def get_mailchimp_lists
    MailchimpEventHandler::Base.fetch_lists_for(self)
  end

  def has_access_to_sign_up_offer?
    !(created_at + 4.days).end_of_day.past?
  end

  # def get_playground
  #   playground || Playground.create!(user_id: id)
  # end

  # has_many :forms
  # has_many :social_call_to_actions
  # has_many :products
  # has_many :orders
  # has_many :tags
  # has_one :address, as: :addressable
  # accepts_nested_attributes_for :address

  # def address
  #   super || build_address
  # end

  # def connected_via_stripe?
  #   self.valid_stripe_credentials?
  # end

  # def valid_stripe_credentials?
  #   !self.stripe_publishable_key.blank? || !self.stripe_access_token.blank? || !self.stripe_user_id.blank?
  # end

  # def fetch_all_products_api_endpoint
  #   "/api/user_products/#{self.stripe_publishable_key}"
  # end

  # def total_revenue
  #   "$#{ ( orders.sum( :amount_cents ) / 100.0 ) }"
  # end

  # def is_subscribed_to_business_plan?
  #   plan_active
  # end
end
