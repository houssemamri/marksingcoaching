class ReferredUserSerializer < ActiveModel::Serializer
  attributes :id, :email, :referral_code, :referrer_id
end
