class CreateContents < ActiveRecord::Migration[6.0]
  def change
    create_table :contents, id: :uuid do |t|
      t.string :identifier
      t.text :body

      t.timestamps
    end
  end
end
