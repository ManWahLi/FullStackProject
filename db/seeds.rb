require "net/http"
require "json"

# Delete all data
ProductTag.delete_all
ProductColor.delete_all
Product.delete_all
Category.delete_all
Brand.delete_all
ProductType.delete_all
Color.delete_all
Tag.delete_all

# Reseed id of each table
ActiveRecord::Base.connection.execute(
  "DELETE FROM sqlite_sequence WHERE name IN (
    'tags', 'brands', 'colors', 'product_types',
    'categories', 'products', 'product_colors', 'product_tags');"
)

# Import data from API and Faker for other tables
url = "http://makeup-api.herokuapp.com/api/v1/products.json"
uri = URI(url)
response = Net::HTTP.get(uri)
products = JSON.parse(response)

products.each do |p|
  next unless %w[brand product_type category name tag_list image_link rating].all? do |key|
                p[key].present?
              end

  brand = Brand.find_or_create_by(brand_name: p["brand"].split.map(&:capitalize).join(" "))
  category = Category.find_or_create_by(category_name: p["category"].capitalize)
  product_type = ProductType.find_or_create_by(product_type_name: p["product_type"].capitalize)
  product = brand.products.find_or_create_by(
    product_name: p["name"],
    price:        p["price"].to_i * 10,
    description:  p["description"],
    image_link:   p["image_link"],
    rating:       p["rating"],
    category:,
    product_type:
  )

  # Retrieve data from product tag list and create data in Tag and ProductTag table
  tags = p["tag_list"]
  tags.each do |tag_name|
    tag = Tag.find_or_create_by(tag_name:)
    ProductTag.find_or_create_by(product:, tag:)
  end

  colors = p["product_colors"]
  colors.each do |c|
    color_name = c["colour_name"]
    color = Color.find_or_create_by(color_name:)
    ProductColor.find_or_create_by(product:, color:)
  end

  puts("Created product #{product.product_name}.")
end

puts("#{Product.count} #{'product'.pluralize(Product.count)} created.")
