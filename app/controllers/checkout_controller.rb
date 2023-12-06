class CheckoutController < ApplicationController
  # POST /checkout/create
  # a product id will be in the params hash params[:product_id]
  def create
    # redirect to home page if the shopping cart is empty
    if session[:shopping_cart].keys.length == 0
      redirect_to root_path
      return
    end

    # define an array to store products detail
    product_data_array = []

    session[:shopping_cart].keys.each do |id|
      product = Product.find(id)
      product_details = {
        price_data: {
          currency:     "cad",
          product_data: {
            name:        product.name,
            description: product.description
          },
          unit_amount:  product.price
        },
        quantity:   session[:shopping_cart][product.id.to_s]
      }
      product_data_array << product_details
    end

    # Handle taxes based on province input by user
    # {
    #   price_data: {
    #     currency:     "cad",
    #     product_data: {
    #       name:        "GST",
    #       description: "Goods and Services Tax"
    #     },
    #     unit_amount:  (product.price_cents * 0.05).to_i
    #   },
    #   quantity:   1
    # }

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
      line_items:           product_data_array
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
    # We took the customer's money!

    # Save customer information
  end

  def cancel
    # Something went wrong with the payment :(
  end
end
