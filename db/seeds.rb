require "csv"
require "active_record"

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
ActiveRecord::Base.connection.execute("DELETE FROM sqlite_sequence WHERE name='tags';")

# open csv files for Tag
filename = Rails.root.join("db/tags_list.csv")
puts "Loading Tag from the CSV file: #{filename}"
csv_data = File.read(filename)
tags = CSV.parse(csv_data, headers: true, encoding: "utf-8")

tags.each do |t|
  Tag.create(tag_name: t["tag_name"])
end

puts "Created #{Tag.count} tags."

# open csv files for Brand
