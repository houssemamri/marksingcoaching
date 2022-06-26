class AddCtaToCourseModules < ActiveRecord::Migration[6.0]
  def change
    add_column :courses, :call_to_action, :string
    add_column :course_modules, :call_to_action, :string
  end
end
