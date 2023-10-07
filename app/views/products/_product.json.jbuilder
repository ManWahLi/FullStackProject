json.extract! product, :id, :product_name, :description, :price, :image_link, :rating, :created_at, :updated_at
json.url product_url(product, format: :json)
