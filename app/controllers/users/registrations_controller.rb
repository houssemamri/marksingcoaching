module Users
  class RegistrationsController < Devise::RegistrationsController
    protected

    def after_sign_up_path_for(resource)
      if session[:lead_magnet_title] && session[:lead_magnet_view_url]
        lead_magnet = LeadMagnet.create(
          user_id: resource.id,
          title: session[:lead_magnet_title],
          view_url: session[:lead_magnet_view_url]
        )
        return lead_magnet_path(lead_magnet)
      elsif session[:lead_magnet_id]
        lead_magnet = LeadMagnet.find(session[:lead_magnet_id])
        return lead_magnet_path(lead_magnet)
      end

      return '/sign-up-offer' unless Payment.find_by(email: resource.email)

      '/dashboard'
    end
  end
end

# def country_code_hash
#   { "United States": "US",
#     "Australia": "AU",
#     "Austria": "AT",
#     "Belgium": "BE",
#     "Canada": "CA",
#     "Denmark": "DK",
#     "Finland": "FI",
#     "France": "FR",
#     "Germany": "DE",
#     "Hong Kong": "HK",
#     "Ireland": "IE",
#     "Italy": "IT",
#     "Japan": "JP",
#     "Luxembourg": "LU",
#     "Netherlands": "NL",
#     "New Zealand": "NZ",
#     "Norway": "NO",
#     "Portugal": "PT",
#     "Singapore": "SG",
#     "Spain": "ES",
#     "Switzerland": "CH",
#     "Sweden": "SE",
#     "United Kingdom": "UK" }
# end
