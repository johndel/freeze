json.array!(@feeds) do |feed|
  json.extract! feed, :id, :category_id, :title, :feed_type, :htmlurl, :xmlurl, :comment
  json.url feed_url(feed, format: :json)
end
