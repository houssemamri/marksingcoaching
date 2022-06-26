class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper ActionText::Engine.helpers

  def authenticate_admin!
    redirect_to root_path, alert: "You're not supposed to go there." unless current_user&.admin?
  end

  # def authenticate_paid_user!
  #   authenticate_user! && paid!
  # end
  # def paid!
  #   p = Payment.find_by(email: current_user.email, paid: true)
  #   if p
  #     true
  #   else
  #     redirect_to root_path, :alert => "You must purchase access to get into the application my friend."
  #   end
  # end

  def after_sign_in_path_for(_resource_or_scope)
    dashboard_path
  end

  def after_sign_out_path_for(_resource_or_scope)
    root_path
  end

  def access_denied(_exception)
    redirect_to root_path, alert: "You must Connect via Stripe in order to create Products! It's easy! Find the button below!"
  end

  def not_found
    fail ActionController::RoutingError, 'Not Found'
  end

  private

  def resource_name
    :user
  end
  helper_method :resource_name

  def resource
    @resource ||= User.new
  end
  helper_method :resource

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
  helper_method :devise_mapping

  def resource_class
    User
  end

  helper_method :resource_class

  # paykickstart
  def paykickstart_params
    num_keys = params.require(:transaction).keys
    permitted_params = {}
    num_keys.each do |num_key|
      permitted_params[num_key] = possible_paykickstart_params
    end
    params.require(:transaction).permit(permitted_params)
  end

  def possible_paykickstart_params
    %i[amount
       affiliate_commission_amount affiliate_commission_percent
       affiliate_email affiliate_first_name affiliate_last_name
       billing_address_1 billing_address_2 billing_city billing_country
       billing_state billing_zip
       buyer_email buyer_first_name buyer_ip buyer_last_name
       buyer_tax_name buyer_tax_number
       campaign_id campaign_name
       coupon_code coupon_rate coupon_type
       currency event invoice_id mode
       next_billing_date payment_processor
       product_id product_name quantity
       ref_affiliate_commission_amount ref_affiliate_commission_percent
       ref_affiliate_email ref_affiliate_first_name ref_affiliate_last_name
       shipping_address_1 shipping_address_2 shipping_city shipping_country
       shipping_state shipping_zip
       tax_amount tax_percent tax_transaction_id
       tracking_id transaction_id transaction_time transaction_type
       vendor_email vendor_first_name vendor_last_name
       licenses hash verification_code]
  end

  def hide_navbar
    @hide_navbar = true
  end

  def hide_footer
    @hide_footer = true
  end
end
