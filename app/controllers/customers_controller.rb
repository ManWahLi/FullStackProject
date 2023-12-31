class CustomersController < ApplicationController
  before_action :load_provinces

  def index
    return if customer_signed_in?

    redirect_to root_path
  end

  def update
    @customer = Customer.find(current_customer.id)
    @customer.update(
      first_name:  params[:first_name],
      last_name:   params[:last_name],
      address:     params[:address],
      city:        params[:city],
      postal_code: params[:postal_code],
      province_id: params[:province_id]
    )
    flash[:customer] = "Your profile is updated." if @customer.save

    redirect_to customers_index_path
  end

  private

  def load_provinces
    @provinces = Province.all
  end
end
