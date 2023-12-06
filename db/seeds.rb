require "csv"
require "net/http"
require "json"

# Delete all data
ActiveStorage::VariantRecord.delete_all
ActiveStorage::Attachment.delete_all
ActiveStorage::Blob.delete_all
AdminUser.delete_all
ProductTag.delete_all
ProductColor.delete_all
Product.delete_all
Category.delete_all
Brand.delete_all
ProductType.delete_all
Color.delete_all
Tag.delete_all
Province.delete_all

# Reseed id of each table
ActiveRecord::Base.connection.execute(
  "DELETE FROM sqlite_sequence WHERE name IN (
    'tags', 'brands', 'colors', 'product_types',
    'categories', 'products', 'product_colors',
    'product_tags', 'admin_users', 'active_storage_attachments',
    'active_storage_blobs', 'active_storage_variant_records',
    'provinces');"
)

# Import data from a csv file to Province table
filename = Rails.root.join("db/tax_rate.csv")
puts "Loading Color from the CSV file: #{filename}"
csv_data = File.read(filename)
provinces = CSV.parse(csv_data, headers: true, encoding: "utf-8")

provinces.each do |p|
  Province.create(
    name: p["PROVINCE"],
    gst:  p["GST"],
    hst:  p["HST"],
    qst:  p["QST"],
    pst:  p["PST"]
  )
end

puts "Created #{Province.count} provinces."

# Import data from a csv file to Color table
filename = Rails.root.join("db/product_color.csv")
puts "Loading Color from the CSV file: #{filename}"
csv_data = File.read(filename)
colors = CSV.parse(csv_data, headers: true, encoding: "utf-8")

colors.each do |c|
  Color.create(name: c["product_color"])
end

puts "Created #{Color.count} colors."

# Create data in Tag and ProductTag table
tags = ["On Sale", "Hot Item", "Organic", "Exclusive", "Limited Edition"]

tags.each do |t|
  Tag.create(name: t)
end

puts "Created #{Tag.count} product tags."

# Import data from API and Faker for other tables
url = "http://makeup-api.herokuapp.com/api/v1/products.json"
uri = URI(url)
response = Net::HTTP.get(uri)
products = JSON.parse(response)

products.each do |p|
  next unless %w[brand product_type category name image_link rating].all? do |key|
                p[key].present?
              end

  brand = Brand.find_or_create_by(name: p["brand"].split.map(&:capitalize).join(" "))
  category = Category.find_or_create_by(name: p["category"].capitalize.gsub("_", ""))
  product_type = ProductType.find_or_create_by(name: p["product_type"].capitalize)
  product = Product.find_or_create_by(
    name:         p["name"].strip,
    price:        p["price"].to_i * 100,
    description:  p["description"],
    image_link:   p["image_link"],
    rating:       p["rating"],
    brand:,
    category:,
    product_type:
  )

  next unless product.persisted?

  # Create data in Tag and ProductTag table
  rand(1..2).times do
    tag = Tag.find(rand(1..Tag.count))
    ProductTag.find_or_create_by(product:, tag:)
  end

  # Randomize product colors and create data in ProductColor table
  rand(1..5).times do
    color = Color.find(rand(1..Color.count))
    ProductColor.find_or_create_by(product:, color:)
  end

  puts("Created product #{product.name}.")
end

puts("#{Product.count} #{'product'.pluralize(Product.count)} created.")
if Rails.env.development?
  AdminUser.create!(email: "admin@example.com", password: "password",
                    password_confirmation: "password")
end
