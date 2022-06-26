class CreateCartItems < ActiveRecord::Migration[6.0]
  def change
    create_table :cart_items, id: :uuid do |t|
      t.references :cart, foreign_key: true, type: :uuid
      t.references :cartable, polymorphic: true, type: :uuid

      t.timestamps
    end
  end
end
