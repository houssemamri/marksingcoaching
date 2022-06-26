class ArticleSerializer < ActiveModel::Serializer
  attributes :id, :title, :slug, :headline, :description, :content
  has_one :user
end
