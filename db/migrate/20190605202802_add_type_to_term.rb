class AddTypeToTerm < ActiveRecord::Migration[6.0]
  def change
    add_column :terms, :type, :string, default: 'UnclassifiedTerm', null: false
  end
end
