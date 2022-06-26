class CreateReferredUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :referred_users, id: :uuid do |t|
      t.string :email
      t.string :referral_code
      t.uuid :referrer_id

      t.timestamps
    end
  end
end
