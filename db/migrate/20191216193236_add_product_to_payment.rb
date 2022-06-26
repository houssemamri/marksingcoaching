class AddProductToPayment < ActiveRecord::Migration[6.0]
  def change
    add_column :payments, :product_name, :string
    add_column :payments, :quantity, :integer, default: 1
    add_column :payments, :transaction_id, :string
  end
end
