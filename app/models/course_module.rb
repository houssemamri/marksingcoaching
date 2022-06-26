class CourseModule < ApplicationRecord
  belongs_to :course

  extend FriendlyId
  friendly_id :title, use: :slugged
  has_rich_text :content
  has_rich_text :description
  has_rich_text :table_of_contents

  include RailsSortable::Model
  set_sortable :sort

  def next_module
    self_index = course.course_modules.index(self)
    next_element = course.course_modules[self_index + 1]
    next_element
  end

  def previous_module
    self_index = course.course_modules.index(self)
    return if self_index.zero?

    previous_element = course.course_modules[self_index - 1]
    previous_element
  end
end
