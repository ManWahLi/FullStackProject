class Province < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :gst, :hst, :qst, :pst, presence: true
end
