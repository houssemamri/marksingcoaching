class CreateCourseModules < ActiveRecord::Migration[6.0]
  def change
    create_table :course_modules, id: :uuid do |t|
      t.references :course, foreign_key: true, type: :uuid
      t.string :title, null: false
      t.string :slug, null: false
      t.string :youtube_link
      t.text :youtube_embed_code
      t.text :description
      t.text :content
      t.integer :sort

      t.timestamps
    end
  end
end
