class ProductColor < ApplicationRecord
  belongs_to :product
  belongs_to :color

  validates :product_id, uniqueness: { scope: :color_id }
end
