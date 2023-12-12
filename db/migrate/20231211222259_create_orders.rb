class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.text :session_id
      t.datetime :payment_date
      t.datetime :delivery_date
      t.references :customer, null: false, foreign_key: true
      t.references :order_status, null: false, foreign_key: true

      t.timestamps
    end
  end
end
