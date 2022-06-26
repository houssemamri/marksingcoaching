class AccessDeterminer
  def self.can_user_access_lead_magnets?(user)
    return true if types_of_user_payments(user).include? 'Lead Magnets'

    return true if users_referrals(user) >= 5

    false
  end

  def self.can_user_access_content_generator?(user)
    types_of_user_payments(user).include? 'Content Idea Generator'
  end

  def self.can_user_access_lead_magnet?(user, lead_magnet)
    return true if lead_magnet.free?

    payment_types = types_of_user_payments(user)
    return true if payment_types.include? 'Lead Magnets'
    return true if lead_magnet.payment_identifiers.any? { |pi| payment_types.include? pi }

    return true if users_referrals(user) >= 5

    false
  end

  def self.can_user_access_social_media_courses?(user)
    return true if types_of_user_payments(user).include? 'Social Media Courses'

    return true if users_referrals(user) >= 10

    false
  end

  def self.types_of_user_payments(user)
    users_payments(user).pluck(:products).reduce([], :concat)
  end

  def self.users_payments(user)
    Payment.where(email: user.email, paid: true)
  end

  def self.users_referrals(user)
    ReferredUser.includes(:referrals).find_by_email(user.email)&.referrals&.count || 0
  end
end
