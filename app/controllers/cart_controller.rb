class CartController < ApplicationController
  before_action :authenticate_user!

  def index
    @needs_stripe = true
    @cart = current_user.fetch_cart
  end
end
