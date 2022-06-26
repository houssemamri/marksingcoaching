class PlansController < ApplicationController
  def upgrade
    # create customer out of current_user
    begin
      stripe_customer = Stripe::Customer.create(email: current_user.email)
      # retreive plan
      plan = if upgrade_params[:plan] == 'year'
               Plan.find_by(tier: 'business', billing_interval: 'year')
             else
               Plan.find_by(tier: 'business', billing_interval: 'month')
             end
      # create subscription
      stripe_subscription = Stripe::Subscription.create(
        customer: stripe_customer.id,
        source: upgrade_params[:stripeToken],
        items: [{ plan: plan.stripe_plan_id }]
      )
      current_user.stripe_customer_id = stripe_customer.id
      current_user.plan_active = true
      current_user.plan_renewing = true
      current_user.plan_expiry = DateTime.strptime(stripe_subscription.current_period_end.to_s, '%s') + 2.days
      current_user.save!
      flash[:success] = 'Successfully upgraded account! Thank you for your purchase!'
    rescue StandardError => e
      flash[:notice] = e.message
    end
    redirect_to edit_user_registration_path
  end

  private

  def upgrade_params
    params.require(:plan).permit(:plan, :stripeToken)
  end
end
