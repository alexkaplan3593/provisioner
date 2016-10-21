json.array!(@products) do |product|
  json.extract! product, :id, :price, :name, :image, :vendor, :discoverer
  json.url product_url(product, format: :json)
end
