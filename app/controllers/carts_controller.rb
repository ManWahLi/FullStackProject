class CartsController < ApplicationController
  def index; end

  # POST /CART
  def create
    logger.debug("adding #{params[:id]} to cart.")
    id = params[:id].to_i
    session[:shopping_cart] << id
    redirect_to root_path
  end

  # DELETE /CART
  def destroy
    # removes params[:id] from cart
    id = params[:id].to_i
    session[:shopping_cart].delete(id)
    redirect_to carts_path
  end
end
