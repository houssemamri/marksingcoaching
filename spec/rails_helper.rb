require 'spec_helper'

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../config/environment', __dir__)
abort('The Rails environment is running in production mode!') if Rails.env.production?

require 'rspec/rails'
require 'database_cleaner'
require 'shoulda/matchers'
require 'support/capybara'

Dir[File.dirname(__FILE__) + '/support/**/*.rb'].sort.each { |f| require f }

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!

  config.include FactoryBot::Syntax::Methods

  # config.include Warden::Test::Helpers
  # config.include Devise::Test::ControllerHelpers, :type => :controller
  config.include Devise::Test::IntegrationHelpers

  config.before(:each) do
    allow_any_instance_of(SendGridEmailer).to receive(:send_referral_welcome_email_to).and_return(true)
    DatabaseCleaner.start
  end
  config.after(:each) { DatabaseCleaner.clean }

  config.include Helpers::Cart
  config.include Helpers::Stripe
end

DatabaseCleaner.strategy = :transaction

Webdrivers.cache_time = 86_400

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end

# OmniAuth.config.test_mode = true
# OmniAuth.config.mock_auth[:stripe_connect] = OmniAuth::AuthHash.new({
#   :info => {
#     :email => "e@mail.com",
#     :stripe_publishable_key => "pk_live_h9xguYGf2GcfytemKs5tHrtg",
#   },
#   :credentials => {
#     :token => "sk_live_AxSI9q6ieYWjGIeRbURf6EG0",
#   },
#   :uid => "acct_NrXu5NBqt5wsvm"
# })
