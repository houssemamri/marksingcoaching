ActiveAdmin.register Course do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :name, :slug, :description, :cost, :vimeo_video_id, :published, :type, :call_to_action, :tag_list
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :slug, :description, :cost, :vimeo_video_id, :published, :type, :call_to_action, :tag_list]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
end
