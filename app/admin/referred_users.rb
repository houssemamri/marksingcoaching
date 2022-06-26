ActiveAdmin.register ReferredUser do
  includes :referrals

  index do
    selectable_column
    column :email
    column :referrer
    column :referral_count do |u|
      u.referrals.count
    end
    column :created_at
    actions
  end

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :email, :referral_code, :referrer_id, :confirmed
  #
  # or
  #
  # permit_params do
  #   permitted = [:email, :referral_code, :referrer_id, :confirmed]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
end
