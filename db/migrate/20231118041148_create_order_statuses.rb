class CreateOrderStatuses < ActiveRecord::Migration[7.0]
  def change
    create_table :order_statuses do |t|
      t.string :status_name

      t.timestamps
    end
  end
end
