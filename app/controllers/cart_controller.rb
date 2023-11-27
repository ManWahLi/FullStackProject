class CartController < ApplicationController
  # POST /CART
  def create
    logger.debug("adding #{params[:id]} to cart.")
    id = params[:id].to_i
    session[:shopping_cart] << id
    redirect_to root_path
  end

  def destroy
    # removes params[:id] from cart
  end
end
