module Helpers
  module Cart
    def add_lead_magnet_to_cart(lead_magnet)
      visit lead_magnet_path(lead_magnet)
      click_on 'Add To Cart'
    end
  end
end
