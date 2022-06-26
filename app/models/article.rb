class Article < ApplicationRecord
  belongs_to :user

  extend FriendlyId
  friendly_id :title, use: :slugged

  has_rich_text :tldr
  has_rich_text :content

  has_one_attached :main_image

  acts_as_taggable
end
