class AddCustomerToPayment < ActiveRecord::Migration[6.0]
  def change
    add_column :payments, :stripe_customer_id, :string
  end
end
