class AddSlugToTerms < ActiveRecord::Migration[5.1]
  def change
    add_column :terms, :slug, :string
    add_index :terms, :slug, unique: true
  end
end
