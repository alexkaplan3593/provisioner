json.array!(@tags) do |tag|
  json.extract! tag, :id, :tag_name, :product_usage, :assoc_tags
  json.url tag_url(tag, format: :json)
end
