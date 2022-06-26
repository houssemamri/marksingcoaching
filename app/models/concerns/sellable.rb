module Sellable
  extend ActiveSupport::Concern

  included do
  end

  def payment_identifier
    "LM-#{id}"
  end

  def payment_identifiers
    [payment_identifier]
  end

  def free?
    price&.zero?
  end

  def tile_url
    cover.service_url if cover.attachment
  end
end
