module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    include OmniConcern
    %w[facebook twitter gplus linkedin].each do |meth|
      define_method(meth) do
        create
      end
    end

    def stripe_connect
      stripe_response = request.env['omniauth.auth']
      user = User.find_by(email: stripe_response.info.email)
      if user
        if user.connected_via_stripe?
          sign_in_and_redirect user
          set_flash_message(:notice, :success, kind: 'Stripe')
        else
          user.stripe_publishable_key = stripe_response.info.stripe_publishable_key
          user.stripe_access_token = stripe_response.credentials.token
          user.stripe_user_id = stripe_response.uid
          user.save!
          sign_in_and_redirect user
          set_flash_message(:notice, :success, kind: 'Stripe')
        end
      else
        user = User.new(create_user_hash_with(stripe_response))
        user.save!
        sign_in_and_redirect user
        set_flash_message(:notice, :success, kind: "Created User with email #{stripe_response.info.email}")
      end
    end

    def create_user_hash_with(stripe_response)
      return_hash = {}
      return_hash[:email] = stripe_response.info.email
      return_hash[:stripe_publishable_key] = stripe_response.info.stripe_publishable_key
      return_hash[:stripe_access_token] = stripe_response.credentials.token
      return_hash[:stripe_user_id] = stripe_response.uid
      return_hash[:password] = SecureRandom.urlsafe_base64
      return_hash
    end
  end
end
