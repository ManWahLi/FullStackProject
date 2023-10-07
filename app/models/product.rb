class Product < ApplicationRecord
  belongs_to :category
  belongs_to :brand
  belongs_to :product_type
  has_many :product_colors
  has_many :colors, through: :product_colors

  has_many :product_tags
  has_many :tags, through: :product_tags

  validates :product_name, :description, :price, presence: true
  validates :product_name, uniqueness: true
  validates :price, numericality: { presence: true, format: { with: /\A\d+(\.\d{2})?\z/ } }
  validates :rating, numericality: { allow_nil: true, format: { with: /\A\d+(\.\d{2})?\z/ } }
end
