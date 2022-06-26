json.extract! payment, :id, :course_id, :user_id, :amount, :stripe_charge_id, :created_at, :updated_at
json.url payment_url(payment, format: :json)
