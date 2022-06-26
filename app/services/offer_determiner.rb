class OfferDeterminer
  MAIN_OFFER_PRICE = 9700

  class Offer < OpenStruct; end

  def self.determine_based_on(payment_params)
    lead_magnet_id = payment_params[:lead_magnet_id]
    return lead_magnet_offer(lead_magnet_id) if lead_magnet_id

    cart_id = payment_params[:cart_id]
    return cart_offer(cart_id) if cart_id

    return content_idea_generator_offer if payment_params[:content_generator]

    return lm_bundle_w_oto(payment_params) if payment_params[:opted_into_offer]

    lm_bundle_offer(payment_params)
  end

  def self.lead_magnet_offer(lead_magnet_id)
    lead_magnet = LeadMagnet.find(lead_magnet_id)

    Offer.new(
      price: lead_magnet.price,
      products: [lead_magnet.payment_identifier]
    )
  end

  def self.cart_offer(cart_id)
    cart = Cart.find(cart_id)

    Offer.new(
      price: cart.price_of_items,
      products: cart.payment_identifiers
    )
  end

  def self.lm_bundle_w_oto(payment_params)
    price = (MAIN_OFFER_PRICE + 2900)
    price -= 5000 if payment_params[:sign_up_offer]

    Offer.new(
      price: price,
      products: ['Lead Magnets', 'Social Media Courses', 'Removed Branding']
    )
  end

  def self.lm_bundle_offer(payment_params)
    price = MAIN_OFFER_PRICE
    price = MAIN_OFFER_PRICE - 5000 if payment_params[:sign_up_offer]

    Offer.new(
      price: price,
      products: ['Lead Magnets', 'Removed Branding']
    )
  end

  def self.content_idea_generator_offer
    price = 4700

    Offer.new(
      price: price,
      products: ['Content Idea Generator']
    )
  end
end
