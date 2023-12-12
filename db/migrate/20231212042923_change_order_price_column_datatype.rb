class ChangeOrderPriceColumnDatatype < ActiveRecord::Migration[7.0]
  def change
    change_column(:order_details, :order_price, :integer)
  end
end
