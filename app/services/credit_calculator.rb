class CreditCalculator
  PerCreditValue = 1000

  class Offer < OpenStruct; end

  def self.determine_credit_amount(user)
    user_as_referrer = ReferredUser.find_by(email: user.email)

    

    
  end
end
