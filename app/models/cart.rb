class Cart < ApplicationRecord
  belongs_to :user
  has_many :cart_items

  def price_of_items
    sum = 0
    cart_items.map do |item|
      sum += item.cartable.price
    end
    sum
  end

  def payment_identifiers
    cart_items.map do |item|
      item.cartable.payment_identifier
    end
  end
end
