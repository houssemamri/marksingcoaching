class CreateCourses < ActiveRecord::Migration[6.0]
  def change
    create_table :courses, id: :uuid do |t|
      t.string :title, null: false
      t.string :slug, null: false
      t.text :description

      t.timestamps
    end
  end
end
