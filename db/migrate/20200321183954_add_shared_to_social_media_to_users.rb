class AddSharedToSocialMediaToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :apply_discount, :boolean, default: false
  end
end
