class HomeController < ApplicationController
  def index
    @products = Product.all.where("rating >= 4.5")
                       .order("RANDOM()")
                       .limit(6)
  end
end
