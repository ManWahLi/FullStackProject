class HomeController < ApplicationController
  def index
    @products = Product.includes(:brand)
    .order("rating DESC")
    .limit(5)
  end
end
