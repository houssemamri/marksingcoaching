class UpdateProductNameToProductsInPayment < ActiveRecord::Migration[6.0]
  def change
    remove_column :payments, :product_name
    add_column :payments, :products, :jsonb, default: []
  end
end
