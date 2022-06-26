class CreateFavorites < ActiveRecord::Migration[6.0]
  def change
    create_table :favorites, id: :uuid do |t|
      t.references :user, foreign_key: true, type: :uuid
      t.references :favoritable, polymorphic: true

      t.timestamps
    end
  end
end
