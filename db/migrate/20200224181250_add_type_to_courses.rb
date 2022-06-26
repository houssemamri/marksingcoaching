class AddTypeToCourses < ActiveRecord::Migration[6.0]
  def change
    add_column :courses, :type, :string, default: 'Course'
  end
end
