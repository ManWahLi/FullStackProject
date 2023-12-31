class Brand < ApplicationRecord
  has_many :products
  has_one_attached :image

  validates :name, presence: true, uniqueness: true
end
