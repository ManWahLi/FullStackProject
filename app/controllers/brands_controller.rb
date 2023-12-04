class BrandsController < ApplicationController
  before_action :set_brand, only: %i[show edit update destroy]
  before_action :add_index_breadcrumb, only: %i[show new edit]

  # GET /brands or /brands.json
  def index
    @brands = Brand.order("name ASC").page(params[:page]).per(10)
    add_breadcrumb("Brands")
  end

  # GET /brands/1 or /brands/1.json
  def show
    @brand = Brand.find(params[:id])
    add_breadcrumb(@brand.name)
  end

  # GET /brands/new
  def new
    @brand = Brand.new
    add_breadcrumb("New")
  end

  # GET /brands/1/edit
  def edit
    add_breadcrumb(@brand.name, brand_path(@brand))
    add_breadcrumb("Edit")
  end

  # POST /brands or /brands.json
  def create
    @brand = Brand.new(brand_params)

    respond_to do |format|
      if @brand.save
        format.html { redirect_to brand_url(@brand), notice: "Brand was successfully created." }
        format.json { render :show, status: :created, location: @brand }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @brand.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /brands/1 or /brands/1.json
  def update
    respond_to do |format|
      if @brand.update(brand_params)
        format.html { redirect_to brand_url(@brand), notice: "Brand was successfully updated." }
        format.json { render :show, status: :ok, location: @brand }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @brand.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /brands/1 or /brands/1.json
  def destroy
    @brand.destroy

    respond_to do |format|
      format.html { redirect_to brands_url, notice: "Brand was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_brand
    @brand = Brand.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def brand_params
    params.require(:brand).permit(:name)
  end

  def add_index_breadcrumb
    add_breadcrumb("Brands", brands_path)
  end
end
