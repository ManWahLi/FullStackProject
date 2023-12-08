class CartsController < ApplicationController
  before_action :load_provinces

  def index; end

  # POST /CART
  def create
    # logger.debug("adding #{params[:id]} to cart.")

    id = params[:id]
    quantity = params[:quantity].to_i

    # Update or add the quantity for the product in the shopping cart
    session[:shopping_cart][id] ||= 0
    session[:shopping_cart][id] += quantity

    redirect_path = request.referer || root_path
    redirect_to redirect_path
  end

  def update
    id = params[:id]
    quantity = params[:quantity].to_i
    return unless session[:shopping_cart][id] != quantity

    session[:shopping_cart][id] = quantity
    product_name = Product.find(id).name
    flash[:notice] = "Quantity of #{product_name} is updated to #{quantity}."
    redirect_to carts_path
  end

  # DELETE /CART
  def destroy
    # removes params[:id] from cart
    id = params[:id]
    session[:shopping_cart].delete(params[:id])
    product_name = Product.find(id).name
    flash[:notice] = "Removed #{product_name} from cart."
    redirect_to carts_path
  end

  private

  def load_provinces
    @provinces = Province.all
  end
end
