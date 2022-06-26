class AddFieldsToCourses < ActiveRecord::Migration[6.0]
  def change
    add_column :courses, :cost, :integer
  end
end
