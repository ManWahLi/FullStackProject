class ProductsController < ApplicationController
  before_action :set_product, only: %i[show edit update destroy]
  before_action :add_index_breadcrumb, only: %i[show new edit]

  # GET /products or /products.json
  def index
    @products = Product.order("rating DESC, name").page(params[:page]).per(10)
    add_breadcrumb("Products")
  end

  # GET /products/1 or /products/1.json
  def show
    @product = Product.find(params[:id])
    add_breadcrumb(@product.name)
  end

  # GET /products/new
  def new
    @product = Product.new
    add_breadcrumb("New")
  end

  # GET /products/1/edit
  def edit
    add_breadcrumb("Edit")
  end

  # POST /products or /products.json
  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html do
          redirect_to product_url(@product), notice: "Product was successfully created."
        end
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1 or /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html do
          redirect_to product_url(@product), notice: "Product was successfully updated."
        end
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1 or /products/1.json
  def destroy
    @product.destroy

    respond_to do |format|
      format.html { redirect_to products_url, notice: "Product was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def search
    wildcard_search = "%#{params[:keywords]}%"
    category_id = params[:dropdown][:selected_category]

    @products = Product.where("name LIKE ?", wildcard_search)

    @products = @products.where("category_id = ?", category_id) if category_id.present?
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_product
    @product = Product.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def product_params
    params.require(:product).permit(:name, :description, :price, :image_link, :rating,
                                    :category_id, :brand_id, :product_type_id)
  end

  def add_index_breadcrumb
    return unless @product.brand.present?

    add_breadcrumb("Brands", brands_path)
    add_breadcrumb(@product.brand.name, brand_path(@product.brand))
  end
end
