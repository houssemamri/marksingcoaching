json.extract! article, :id, :title, :slug, :headline, :description, :content, :user_id, :created_at, :updated_at
json.url article_url(article, format: :json)
