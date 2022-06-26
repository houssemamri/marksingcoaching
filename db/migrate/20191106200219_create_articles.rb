class CreateArticles < ActiveRecord::Migration[6.0]
  def change
    enable_extension 'pgcrypto'

    create_table :articles, id: :uuid do |t|
      t.string :title
      t.string :slug
      t.string :headline
      t.string :description
      t.text :content
      t.boolean :published, default: false
      t.references :user, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
