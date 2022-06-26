class IntegrationsController < ApplicationController
  before_action :authenticate_user!

  def index; end

  def active_campaign; end

  def mailchimp; end

  def zapier
    unless current_user.integrated_with_zapier?
      current_user.zapier_api_key = 'zap_key_' + SecureRandom.urlsafe_base64
      current_user.save
    end
  end

  def update
    flash[:notice] = if current_user.update(integration_params)
                       'Integration Successful'
                     else
                       'Integration Failed'
                     end
    redirect_to integrations_path
  end

  private

  def integration_params
    params.require(:user).permit(
      :active_campaign_api_key, :active_campaign_url, :mailchimp_api_key
    )
  end
end
