class OrdersController < ApplicationController
  def index
    @orders = Order.where(customer_id: current_customer.id)
  end
end
