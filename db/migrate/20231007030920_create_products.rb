class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :product_name
      t.text :description
      t.decimal :price
      t.text :image_link
      t.decimal :rating

      t.timestamps
    end
  end
end
