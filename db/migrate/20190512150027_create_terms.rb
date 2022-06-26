class CreateTerms < ActiveRecord::Migration[5.1]
  def change
    create_table :terms, id: :uuid do |t|
      t.string :name
      t.text :definition
      t.text :more

      t.timestamps
    end
  end
end