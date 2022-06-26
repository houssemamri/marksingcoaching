class CartItemsController < ApplicationController
  before_action :authenticate_user!

  def create
    cart = current_user.fetch_cart
    items = cart.cart_items.where(cart_item_params)
    if items.empty?
      cart.cart_items.create(
        cart_item_params
      )
      flash[:success] = 'Successfully added Item to Cart'
    else
      flash[:success] = 'This Item is already in your Cart'
    end
    redirect_to '/cart'
  end

  def destroy
    cart = current_user.fetch_cart
    item = CartItem.find(params[:id])
    item&.destroy
    flash[:success] = 'Successfully removed Item from Cart'
    redirect_to '/cart'
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:cartable_id, :cartable_type)
  end
end
