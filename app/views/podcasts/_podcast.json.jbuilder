json.extract! podcast, :id, :title, :description, :published_on, :libsyn_id, :content, :created_at, :updated_at
json.url podcast_url(podcast, format: :json)
