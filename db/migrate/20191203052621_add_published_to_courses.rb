class AddPublishedToCourses < ActiveRecord::Migration[6.0]
  def change
    add_column :courses, :published, :boolean, default: false
  end
end
