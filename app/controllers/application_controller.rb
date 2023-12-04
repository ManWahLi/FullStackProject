class ApplicationController < ActionController::Base
  before_action :initialize_session
  helper_method :cart
  before_action :set_breadcrumbs

  private

  def initialize_session
    # this will initialize the shopping cart to empty for new users
    # dictionary datatype with product id as keys and quantity as value
    session[:shopping_cart] ||= {}
  end

  def cart
    # pass dictionary keys to find
    Product.find(session[:shopping_cart].keys)
  end

  def add_breadcrumb(label, path = nil)
    @breadcrumbs << {
      label: label,
      path: path
    }
  end

  def set_breadcrumbs
    @breadcrumbs = []
  end
end
