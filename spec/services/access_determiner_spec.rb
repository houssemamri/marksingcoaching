require 'rails_helper'

RSpec.describe AccessDeterminer do
  let(:free_lead_magnet) { create :lead_magnet, price: 0 }
  let(:first_lead_magnet) { create :lead_magnet }
  let(:second_lead_magnet) { create :lead_magnet }

  let(:user) { create :user }

  describe 'self.can_user_access_lead_magnet?' do
    it 'returns true if product is free' do
      accessible = AccessDeterminer.can_user_access_lead_magnet? user, free_lead_magnet
      expect(accessible).to be true
    end

    it 'should return true if payment exists for lead_magnet' do
      accessible = AccessDeterminer.can_user_access_lead_magnet? user, first_lead_magnet
      expect(accessible).to be false

      products = first_lead_magnet.payment_identifiers
      payment = Payment.create(
        email: user.email,
        products: products,
        paid: true,
        amount: first_lead_magnet.price
      )

      accessible = AccessDeterminer.can_user_access_lead_magnet? user, first_lead_magnet
      expect(accessible).to be true
    end

    it 'should return true if payment exists for all lead_magnets' do
      accessible = AccessDeterminer.can_user_access_lead_magnet? user, first_lead_magnet
      expect(accessible).to be false

      payment = Payment.create(
        email: user.email,
        products: ['Lead Magnets'],
        paid: true,
        amount: first_lead_magnet.price
      )

      accessible = AccessDeterminer.can_user_access_lead_magnet? user, first_lead_magnet
      expect(accessible).to be true
    end
  end
end
