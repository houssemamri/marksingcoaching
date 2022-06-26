module Users
  class SettingsController < ApplicationController
    before_action :authenticate_user!

    def connect_with_stripe
      render 'products/connect_stripe'
    end

    def create_and_connect_stripe_account
      stripe_response = Stripe::Account.create(
        type: 'standard',
        email: current_user.email
      )
      current_user.stripe_user_id = stripe_response['id']
      current_user.stripe_publishable_key = stripe_response['keys']['publishable']
      current_user.stripe_access_token = stripe_response['keys']['secret']
      current_user.save
    rescue StandardError => e
      flash[:notice] = e.message.gsub('An account', 'A Stripe account')
      redirect_to '/users/connect_with_stripe'
    end

    def shipping
      @user = current_user
      render 'shipping'
    end

    def update
      @user = current_user
      if @user.update_attributes(settings_params)
        flash[:success] = 'Settings updated successfully! :D'
        redirect_to '/users/shipping-settings'
      else
        flash[:alert] = 'Settings failed to update :('
        render 'shipping'
      end
    end

    private

    def settings_params
      params.require(:user).permit(:shipping_with_commercy, address_attributes: %i[line_one line_two city state zip_code apartment])
    end
  end
end
