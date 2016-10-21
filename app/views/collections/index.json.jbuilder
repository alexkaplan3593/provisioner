json.array!(@collections) do |collection|
  json.extract! collection, :id, :product_id, :user_id, :collection_name
  json.url collection_url(collection, format: :json)
end
