json.array!(@categories) do |category|
  json.extract! category, :id, :category_name, :image, :slug
  json.url category_url(category, format: :json)
end
