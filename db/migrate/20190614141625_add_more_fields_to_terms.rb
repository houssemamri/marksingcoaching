class AddMoreFieldsToTerms < ActiveRecord::Migration[6.0]
  def change
    add_column :terms, :sort, :integer
  end
end
