module ReferredUsersHelper
  def url_escaped_share_message(referral_url)
    CGI.escape(share_message(referral_url))
  end

  def share_message(referral_url)
    "Sign up for #123LeadMagnets and Get $10 to use their Lead Magnets today: #{referral_url}"
  end
end
