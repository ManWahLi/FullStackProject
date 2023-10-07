json.extract! product, :id, :product_name, :description, :price, :image_link, :rating, :category_id, :brand_id, :product_type_id, :created_at, :updated_at
json.url product_url(product, format: :json)
