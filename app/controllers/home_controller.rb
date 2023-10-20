class HomeController < ApplicationController
  def index
    @products = Product.includes(:brand, :category, :product_type, :colors, :tags)
                       .where("rating >= 4.5")
                       .order("RANDOM()")
                       .limit(6)
  end
end
