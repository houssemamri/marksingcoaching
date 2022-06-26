module Ahoy
  class Store < Ahoy::DatabaseStore
  end
end

Ahoy.server_side_visits = :when_needed

# set to true for JavaScript tracking
Ahoy.api = false
