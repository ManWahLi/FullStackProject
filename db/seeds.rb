require "csv"
require "faker"
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

# Import data from a csv file to Color table
filename = Rails.root.join("db/color.csv")
puts "Loading Color from the CSV file: #{filename}"
csv_data = File.read(filename)
colors = CSV.parse(csv_data, headers: true, encoding: "utf-8")

colors.each do |c|
  Color.create(color_name: c["color_name"])
end

puts "Created #{Color.count} colors."

# Import data from API and Faker for other tables
url = "http://makeup-api.herokuapp.com/api/v1/products.json"
uri = URI(url)
response = Net::HTTP.get(uri)
products = JSON.parse(response)

products.each do |p|
  next unless %w[brand product_type category name price description tag_list image_link
                 rating].all? do |key|
                p[key].present?
              end

  brand = Brand.find_or_create_by(brand_name: p["brand"])
  category = Category.find_or_create_by(category_name: p["category"])
  product_type = ProductType.find_or_create_by(product_type_name: p["product_type"])
  product = brand.products.create(
    product_name: p["name"],
    price:        Faker::Commerce.price,
    description:  Faker::Lorem.sentence,
    image_link:   p["image_link"],
    rating:       p["rating"],
    category:,
    product_type:
  )

  # Retrieve data from product tag list and create data in Tag and ProductTag table
  tags = p["tag_list"]
  tags.each do |tag_name|
    tag = Tag.find_or_create_by(tag_name:)
    ProductTag.create(product:, tag:)
  end

  # Randomize product colors and create data in ProductColor table
  rand(1..5).times do
    color = Color.find(rand(1..20))
    ProductColor.find_or_create_by(product:, color:)
  end
end
