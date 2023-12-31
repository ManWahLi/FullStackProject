class Product < ApplicationRecord
  belongs_to :category
  belongs_to :brand
  belongs_to :product_type
  has_many :product_colors
  has_many :colors, through: :product_colors
  has_many :product_tags
  has_many :tags, through: :product_tags
  accepts_nested_attributes_for :product_tags, allow_destroy: true

  validates :name, :description, :price, presence: true
  validates :name, uniqueness: true
  validates :price, numericality: { format: { with: /\A\d+(\.\d{2})?\z/ } }
  validates :rating, numericality: { format: { with: /\A\d+(\.\d{2})?\z/ } }
end
