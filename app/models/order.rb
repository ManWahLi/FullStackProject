class Order < ApplicationRecord
  belongs_to :customer
  belongs_to :order_status

  validates :session_id, presence: true, uniqueness: true
end
