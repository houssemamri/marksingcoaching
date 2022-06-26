class SendGridEmailer
  include SendGrid

  FROM_EMAIL = 'us@123leadmagnets.com'.freeze

  REFERRAL_USER_WELCOME_EMAIL_TEMPLATE_ID = 'd-ca0e568c51dc47aab4cd4d9dbf6552d5'.freeze

  def send_referral_welcome_email_to(referred_user)
    data = {
      personalizations: [
        {
          to: [
            {
              email: referred_user.email
            }
          ],
          dynamic_template_data: {
            "referralURL": referred_user.referral_url,
            "referrerURL": referred_user.referrer_url
          }
        }
      ],
      from: {
        email: FROM_EMAIL
      },
      template_id: REFERRAL_USER_WELCOME_EMAIL_TEMPLATE_ID
    }

    send(data)
  end

  private

  def send(data)
    sg = SendGrid::API.new(api_key: ENV['SENDGRID_KEY'])

    begin
      response = sg.client.mail._('send').post(request_body: data)
      puts response.status_code
      puts response.body
      puts response.headers
      response.status_code
    rescue Exception => e
      puts e.message
      e.message
    end
  end
end
