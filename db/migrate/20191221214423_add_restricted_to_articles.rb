class AddRestrictedToArticles < ActiveRecord::Migration[6.0]
  def change
    add_column :articles, :restricted, :boolean, default: false
  end
end
