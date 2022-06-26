class UpdateCoursePaymentsToPaymentAndIntegratePayQuickStart < ActiveRecord::Migration[6.0]
  def change
    rename_table :course_payments, :payments

    add_column :payments, :payquickstart_hash, :jsonb
    add_column :payments, :paid, :boolean, default: false
    add_column :payments, :refunded, :boolean, default: false
    add_column :payments, :purchaser_email, :string
    add_column :payments, :user_email, :string
    
    remove_column :payments, :stripe_charge_id, :string
  end
end
