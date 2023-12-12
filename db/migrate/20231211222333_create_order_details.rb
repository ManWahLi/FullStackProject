class CreateOrderDetails < ActiveRecord::Migration[7.0]
  def change
    create_table :order_details do |t|
      t.references :order, null: false, foreign_key: true
      t.string :item_name
      t.float :order_price
      t.integer :order_quantity

      t.timestamps
    end
  end
end
