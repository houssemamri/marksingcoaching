class PaymentSerializer < ActiveModel::Serializer
  attributes :id, :amount, :stripe_charge_id
  has_one :course
  has_one :user
end
