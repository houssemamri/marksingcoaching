module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def stripe_connect
      # Delete the code inside of this method and write your own.
      # The code below is to show you where to access the data.
      fail request.env['omniauth.auth'].to_yaml
    end
  end
end
