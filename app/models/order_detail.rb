class OrderDetail < ApplicationRecord
  belongs_to :order

  validates :item_name, :order_price, :order_quantity, presence: true
end
