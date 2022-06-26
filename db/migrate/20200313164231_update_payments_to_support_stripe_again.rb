class UpdatePaymentsToSupportStripeAgain < ActiveRecord::Migration[6.0]
  def change
    rename_column :payments, :transaction_id, :stripe_charge_id

    remove_column :payments, :purchaser_email, :string
    remove_column :payments, :user_email, :string
    remove_column :payments, :course_id, :bigint
  end
end
