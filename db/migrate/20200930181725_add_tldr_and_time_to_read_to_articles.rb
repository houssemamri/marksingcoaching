class AddTldrAndTimeToReadToArticles < ActiveRecord::Migration[6.0]
  def change
    add_column :articles, :tldr, :text
    add_column :articles, :time_to_read, :integer
    add_column :articles, :featurable, :boolean, default: :false
  end
end
