class SalesPagesController < ApplicationController
  before_action :authenticate_user!, only: [:sign_up_offer]
  # layout :resolve_layout

  def about
    @needs_stripe = true
  end

  def base
    @needs_stripe = true

    @ebooks = LeadMagnet.pluck(:title)
  end

  def library_pass
    @needs_stripe = true
  end

  def sign_up_offer
    @needs_stripe = true
    @hide_navbar = true

    expiration_date = (current_user.created_at + 4.days).end_of_day
    if expiration_date.past?
      flash[:notice] = 'This offer has expired.'
      redirect_to dashboard_path
    else
      @expiration_date = expiration_date
    end
  end

  def offer_0_100_lead_generation
    @needs_stripe = true
  end

  def sign_up_for_lead_gen; end

  def custom_solution; end

  private

  def resolve_layout
    case action_name
    when 'offer_0_100_lead_generation', 'sign_up_for_lead_gen'
      'sales_pages'
    else
      'marketing/index'
    end
  end
end
