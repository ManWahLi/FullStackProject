class CustomersController < ApplicationController
  before_action :load_provinces

  def index
  end

  def update
  end

  private

  def load_provinces
    @provinces = Province.all
  end
end
