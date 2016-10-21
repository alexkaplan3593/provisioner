json.array!(@likes) do |like|
  json.extract! like, :id, :product_id, :user_id
  json.url like_url(like, format: :json)
end
