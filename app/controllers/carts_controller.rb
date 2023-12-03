class CartsController < ApplicationController
  def index; end

  # POST /CART
  def create
    # logger.debug("adding #{params[:id]} to cart.")

    id = params[:id]
    quantity = params[:quantity].to_i

    # Update or add the quantity for the product in the shopping cart
    session[:shopping_cart][id] ||= 0
    session[:shopping_cart][id] += quantity

    redirect_to root_path
  end

  # DELETE /CART
  def destroy
    # removes params[:id] from cart
    session[:shopping_cart].delete(params[:id])
    redirect_to carts_path
  end
end
