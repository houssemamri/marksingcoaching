class LeadCaptureToolGeneratorController < ApplicationController
  layout 'marketing/lead_capture_tools'

  def build
    @lead_capture_tool = LeadCaptureTool.new
  end

  def post_build
    session[:lead_capture_tool_tool_type] = lead_capture_tool_params[:tool_type]
    if !session[:lead_capture_tool_tool_type].present?
      flash[:notice] = 'Please select a Type to continue.'
      redirect_to build_path
    else
      redirect_to pick_path
    end
  end

  def pick
    @needs_datatables = true
    @lead_magnet = LeadMagnet.new
    @lead_magnets = LeadMagnet.includes(
      :tags, base_cover_attachment: :blob
    ).where(can_be_used_to_build_a_list: true)
    @lead_capture_tool = LeadCaptureTool.new(
      type: session[:lead_capture_tool_tool_type]
    )
  end

  def picked_own_lead_magnet
    session[:lead_magnet_title] = lead_magnet_params[:title]
    session[:lead_magnet_view_url] = lead_magnet_params[:view_url]
    if !session[:lead_magnet_title].present? || !session[:lead_magnet_view_url].present?
      flash[:notice] = 'Please set a Name and URL for your Lead Magnet.'
      redirect_to pick_path
    else
      redirect_to lead_capture_tool_sign_up_path
    end
  end

  def picked_one_of_our_lead_magnets
    session[:lead_magnet_id] = lead_magnet[:chosen_id]
    if !session[:lead_magnet_id].present?
      flash[:notice] = 'Please pick a proper Lead Magnet option.'
      redirect_to pick_path
    else
      redirect_to lead_capture_tool_sign_up_path
    end
  end

  def sign_up
    set_lead_magnet
    @lead_capture_tool = LeadCaptureTool.new(
      type: session[:lead_capture_tool_tool_type]
    )
  end

  def widget_preview
    set_lead_magnet
  end

  private

  def set_lead_magnet
    @lead_magnet = if session[:lead_magnet_id]
                     LeadMagnet.find(session[:lead_magnet_id])
                   else
                     LeadMagnet.new(
                       title: "Get #{session[:lead_magnet_title]}",
                       view_url: session[:lead_magnet_view_url]
                     )
                   end
  end

  def lead_capture_tool_params
    params.require(:lead_capture_tool).permit(
      :name, :tool_type
      # :user_id, :ask_for_name,
      # :title, :headline, :text_alignment,
      # :lead_magnet_name, :lead_magnet_url,
      # :lead_magnet_type, :lead_magnet_id
    )
  end

  def lead_magnet_params
    params.require(:lead_magnet).permit(
      :title, :view_url, :chosen_id
    )
  end
end
