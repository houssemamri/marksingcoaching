class Course < ApplicationRecord
  has_many :course_modules, -> { order(sort: :asc) }

  extend FriendlyId
  friendly_id :title, use: :slugged
  has_rich_text :description

  has_one_attached :cover

  acts_as_taggable
end
