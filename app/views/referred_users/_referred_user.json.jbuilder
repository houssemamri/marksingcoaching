json.extract! referred_user, :id, :email, :referral_code, :referrer_id, :created_at, :updated_at
json.url referred_user_url(referred_user, format: :json)
