class PodcastSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :published_on, :libsyn_id, :content
end
