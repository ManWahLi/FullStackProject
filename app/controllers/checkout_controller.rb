class CheckoutController < ApplicationController
  before_action :set_product_data_array
  # POST /checkout/create
  def create
    # Establish a connection with Stripe and then redirect the user to the payment screen.

    # this call here, will have our server connect to stripe!
    # strip gem access to private key to setup the session behind the scenes
    # one of th bits of info is the INTERNAL ID for the session
    # so after this we need to provide that ID back to stripe for authentication.
    # That step happens in the JAVASCRIPT
    @session = Stripe::Checkout::Session.create(
      payment_method_types: ["card"],
      mode:                 "payment",
      success_url:          checkout_success_url + "?session_id={CHECKOUT_SESSION_ID}",
      cancel_url:           checkout_cancel_url,
      line_items:           @product_data_array
    )

    # BEFORE this, you will probably have wanted to LOOP over all line items to create and array of these items.
    # we're sticking to just ONE item for the demo.
    # would also have to loop through all taxes for that province and add it as a line item as well!
    # might be better ways with stripe API to add taxes! So go look on your own!

    # Then redirect the user to the payment screen.
    # ruby inside of the javascript!...
    # executed on server to input data into the JS before the client receives it!
    # respond_to do |format|
    # 	format.js #render app/views/checkout/create.js.erb
    # end
    redirect_to @session.url, allow_other_host: true
  end

  def success
    # Retrieve the session ID from the query parameters
    session_id = params[:session_id]

    # Retrieve the session from Stripe to check the payment status
    checkout_session = Stripe::Checkout::Session.retrieve(session_id)

    return unless checkout_session.payment_status == "paid"

    @order_summary = []
    order = Order.where(session_id:, customer_id: current_customer.id,
                        order_status_id: 2).first

    if order.nil?
      order = Order.find_or_create_by(
        session_id:,
        customer_id:     current_customer.id,
        order_status_id: 2,
        payment_date:    Time.current
      )

      @product_data_array.each do |d|
        line = OrderDetail.find_or_create_by(
          order_id:       order.id,
          item_name:      d[:price_data][:product_data][:name],
          order_price:    d[:price_data][:unit_amount],
          order_quantity: d[:quantity]
        )
        @order_summary << line
      end
    else
      @order_summary = OrderDetail.where(order_id: order.id).to_a
    end
  end

  def cancel
    # Something went wrong with the payment :(
  end

  private

  def set_product_data_array
    unless customer_signed_in?
      redirect_to new_customer_session_path
      return
    end

    if current_customer.province_id.nil?
      flash[:cart] = "Please update your profile before checkout."
      redirect_to carts_path
      return
    end

    # redirect to home page if the shopping cart is empty
    if session[:shopping_cart].empty?
      redirect_to root_path
      return
    end

    # define an array to store products detail
    @product_data_array = []
    total_price = 0

    session[:shopping_cart].each_key do |id|
      product = Product.find(id)
      product_details = {
        price_data: {
          currency:     "cad",
          product_data: {
            name:        product.name,
            description: product.description.truncate(100, separator: " ", omission: " ...")
          },
          unit_amount:  product.price
        },
        quantity:   session[:shopping_cart][product.id.to_s]
      }
      total_price += product.price * session[:shopping_cart][product.id.to_s]
      @product_data_array << product_details
    end

    province = Province.find(current_customer.province_id)
    taxes = {
      "GST" => province.gst,
      "HST" => province.hst,
      "QST" => province.qst,
      "PST" => province.pst
    }

    taxes.each do |tax, value|
      next unless value.positive?

      tax_detail = {
        price_data: {
          currency:     "cad",
          product_data: {
            name: "#{tax} - #{value * 100}%"
          },
          unit_amount:  (total_price * value).to_i
        },
        quantity:   1
      }
      @product_data_array << tax_detail
    end
  end
end
