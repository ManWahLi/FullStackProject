class DropOrderAndOrderProduct < ActiveRecord::Migration[7.0]
  def change
    drop_table :order_products
    drop_table :orders
  end
end
