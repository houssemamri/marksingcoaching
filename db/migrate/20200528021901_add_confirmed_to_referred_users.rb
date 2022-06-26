class AddConfirmedToReferredUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :referred_users, :confirmed, :boolean, default: false
  end
end
