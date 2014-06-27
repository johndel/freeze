json.array!(@articles) do |article|
  json.extract! article, :id, :starred, :feed_id, :clicked, :title, :content, :author, :url, :source, :article_published, :article_updated, :read_at
  json.url article_url(article, format: :json)
end
