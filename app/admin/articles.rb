ActiveAdmin.register Article do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :title, :slug, :headline, :description, :content, :published, :user_id, :restricted, :tag_list
  #
  # or
  #
  # permit_params do
  #   permitted = [:title, :slug, :headline, :description, :content, :published, :user_id, :restricted, :tag_list]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
end
