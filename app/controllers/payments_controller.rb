class PaymentsController < ApplicationController
  before_action :authenticate_user!, only: [:apply_share_discount]

  def new
    @payment = Payment.new
  end

  def create
    # process/determine "offer" (based on params):
    # - price
    # - products
    offer = OfferDeterminer.determine_based_on(payment_params)

    begin
      # stripe customer should be on User.
      customer = Stripe::Customer.create({
                                           source: stripe_token,
                                           email: payment_params[:email]
                                         })

      charge = Stripe::Charge.create({
                                       amount: offer.price,
                                       currency: 'usd',
                                       description: 'Mark Sing Coaching',
                                       customer: customer.id
                                     })

      payment = Payment.new(
        amount: offer.price,
        email: payment_params[:email],
        paid: true,
        products: offer.products,
        stripe_charge_id: charge.id,
        stripe_customer_id: customer.id
      )

      if payment.save
        flash[:success] = 'Success! Your purchase was successful! Go conquer the world!'
      else
        flash[:notice] = 'There was an error with your payment.'
      end
    rescue StandardError => e
      flash[:notice] = e.message
    end

    redirect_to payment
  end

  def show
    @payment = Payment.find(params[:id])
    @resource = User.new(email: @payment.email) unless current_user
  end

  def apply_share_discount
    current_user.apply_discount = true
    if current_user.save
      flash[:success] = 'Thank you for your support! You now have 50% OFF 😁'
    else
      flash[:notice] = 'Something went wrong... contact us to get it resolved.'
    end
    redirect_to '/dashboard'
  end

  private

  def payment_params
    params.require(:payment).permit(:email, :opted_into_offer, :sign_up_offer, :content_generator, :lead_magnet_id, :cart_id, :stripeToken)
  end

  def stripe_token
    payment_params[:stripeToken]
  end
end
