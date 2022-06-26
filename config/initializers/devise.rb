Devise.setup do |config|
  config.mailer_sender = 'us@123leadmagnets.com'

  require 'devise/orm/active_record'

  config.case_insensitive_keys = [:email]
  config.strip_whitespace_keys = [:email]
  config.skip_session_storage = [:http_auth]
  config.stretches = Rails.env.test? ? 1 : 11
  config.reconfirmable = true
  config.expire_all_remember_me_on_sign_out = true
  config.password_length = 6..128
  config.email_regexp = /\A[^@\s]+@[^@\s]+\z/
  config.reset_password_within = 6.hours

  config.omniauth :facebook,
                  ENV['FACEBOOK_APP_ID'],
                  ENV['FACEBOOK_SECRET'],
                  display: 'popup',
                  scope: 'email',
                  info_fields: 'email,name'
  config.omniauth :gplus,
                  ENV['GOOGLE_CLIENT_ID'],
                  ENV['GOOGLE_CLIENT_SECRET'],
                  display: 'popup',
                  scope: 'userinfo.email, userinfo.profile'
  # config.omniauth :linkedin, linkedin_app_id ,linkedin_secret_key , :display => "popup", :scope => 'r_emailaddress,r_basicprofile'
  # config.omniauth :twitter, twitter_app_id , twitter_secret_key , :display => "popup" , :scope => 'email'

  # ADDED THIS TO ALLOW FOR LOGGING IN WITH STRIPE. REMOVING BECAUSE OF HOW IT INTRODUCED BREAKING LOGIC
  config.omniauth :stripe_connect, ENV['STRIPE_CONNECT_CLIENT_ID'], ENV['STRIPE_SECRET'],
                  scope: 'read_write',
                  stripe_landing: 'register'
end

# Rails.application.config.to_prepare do
#   MARKETING_LAYOUT = 'marketing/index'.freeze
#   DASHBOARD_LAYOUT = 'dashboard/index'.freeze

#   Devise::SessionsController.layout MARKETING_LAYOUT
#   Devise::RegistrationsController.layout proc { |_controller| user_signed_in? ? DASHBOARD_LAYOUT : MARKETING_LAYOUT }
#   Devise::ConfirmationsController.layout MARKETING_LAYOUT
#   Devise::UnlocksController.layout MARKETING_LAYOUT
#   Devise::PasswordsController.layout MARKETING_LAYOUT
# end
