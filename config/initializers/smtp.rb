ActionMailer::Base.smtp_settings = {
  user_name: ENV['SENDGRID_UN'],
  password: ENV['SENDGRID_PW'],
  domain: '123leadmagnets.com',
  address: 'smtp.sendgrid.net',
  port: 465,
  authentication: :plain,
  enable_starttls_auto: true
}
