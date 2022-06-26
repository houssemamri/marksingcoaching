class CourseModuleSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :content
  has_one :course
end
