class ReferredUsersController < ApplicationController
  prepend_before_action :ref_to_cookie
  before_action :skip_first_page, only: :new
  before_action :handle_ip, only: :create

  def new
    @referred_user = ReferredUser.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  def create
    ref_code = request.cookies['h_ref']
    email = referred_user_params[:email]

    @referred_user = ReferredUser.find_or_initialize_by(email: email)
    unless @referred_user.persisted?
      @referred_user.referrer = ReferredUser.find_by(referral_code: ref_code) if ref_code
    end

    if @referred_user.save
      cookies[:h_email] = { value: @referred_user.email }
      redirect_to '/refer-a-friend'
    else
      logger.info("Error saving referred_user with email, #{email}")
      redirect_to unlock_path, alert: "Are you sure that's a valid email?"
    end
  end

  def refer
    # @referred_user = ReferredUser.includes(:referrals).find_by_email(cookies[:h_email] || current_user&.email)
    @referred_user = ReferredUser.find_by_email(cookies[:h_email] || current_user&.email)

    respond_to do |format|
      if @referred_user.nil?
        format.html { redirect_to unlock_path }
      else
        @referrals_total = @referred_user.referrals.count
        @referrals_confirmed_count = @referred_user.referrals.where(confirmed: true).count
        format.html # refer.html.erb
      end
    end
  end

  def confirm_and_set_referrer_cookie
    @referred_user = ReferredUser.includes(:referrals).find_by(id: params[:id])

    if @referred_user
      @referred_user.confirmed = true
      @referred_user.save

      cookies[:h_email] = { value: @referred_user.email }
      redirect_to '/refer-a-friend'
    else
      redirect_to unlock_path, alert: 'That email has not been referred.'
    end
  end

  private

  def referred_user_params
    params.require(:referred_user).permit(:email, :referral_code, :referrer_id)
  end

  def skip_first_page
    email = cookies[:h_email] || current_user&.email
    if email && ReferredUser.find_by_email(email)
      redirect_to '/refer-a-friend'
    else
      cookies.delete :h_email
    end
  end

  def handle_ip
    # Prevent someone from gaming the site by referring themselves.
    # Presumably, users are doing this from the same device so block
    # their ip after their ip appears three times in the database.

    address = request.env['HTTP_X_FORWARDED_FOR']
    return if address.nil?

    current_ip = IpAddress.find_by_address(address)
    if current_ip.nil?
      current_ip = IpAddress.create(address: address, count: 1)
    elsif current_ip.count > 2
      logger.info('IP address has already appeared three times in our records.
                   Redirecting referred_user back to landing page.')
      redirect_to unlock_path, alert: 'There have been too many referrals from the same location.'
    else
      current_ip.count += 1
      current_ip.save
    end
  end

  def ref_to_cookie
    permitted_params = params.permit(:ref, :controller, :action)
    unless params.key?(:ref) && ReferredUser.find_by(referral_code: params[:ref]).nil?
      h_ref = { value: params[:ref], expires: 1.week.from_now }
      cookies[:h_ref] = h_ref
    end

    # user_agent = request.env['HTTP_USER_AGENT']
    # return unless user_agent && !user_agent.include?('facebookexternalhit/1.1')
    # redirect_to proc { url_for(permitted_params.except(:ref)) }
  end
end
