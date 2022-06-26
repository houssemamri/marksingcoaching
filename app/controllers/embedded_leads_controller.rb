class EmbeddedLeadsController < ApplicationController
  layout 'embedded_leads', except: [:display]
  layout 'landing_page', only: [:display]

  skip_before_action :verify_authenticity_token, only: %i[script styles]

  def script
    base_file = Webpacker.manifest.lookup!('script.js')
    send_file(
      "#{Rails.root}/public#{base_file}",
      filename: base_file,
      type: 'application/javascript'
    )
  end

  def styles
    base_file = Webpacker.manifest.lookup!('embeddedStyles.css')
    send_file(
      "#{Rails.root}/public#{base_file}",
      filename: base_file,
      type: 'text/css'
    )
  end

  def pop_up_js
    base_file = Webpacker.manifest.lookup!('popUp.js')
    send_file(
      "#{Rails.root}/public#{base_file}",
      filename: base_file,
      type: 'application/javascript'
    )
  end

  def widget
    response.headers.delete 'X-Frame-Options'
    @hide_navbar = true

    user = User.find(params[:user_id])
    set_embeddable
    @lead = Lead.new(user: user, resourceable: @embeddable)
  end

  def thank_you
    response.headers.delete 'X-Frame-Options'
    @lead = Lead.find(params[:lead_id])
  end

  def landing_page
    user = User.find(params[:user_id])
    set_embeddable
    @lead = Lead.new(user: user, resourceable: @ebook)
  end

  def display
    @landing_page = LeadCaptureTool.friendly.find(params[:id])
    ahoy.track 'Landing Page View', properties: { landing_page_id: @landing_page.id }

    user = @landing_page.user
    @ebook = @landing_page.lead_magnet
    @lead = Lead.new(user: user, resourceable: @ebook)
  end

  private

  def set_embeddable
    @embeddable = LeadMagnet.find(params[:embeddable_id])
  end
end
