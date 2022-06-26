class AddContentToCourseModules < ActiveRecord::Migration[6.0]
  def change
    add_column :course_modules, :table_of_contents, :text
  end
end
