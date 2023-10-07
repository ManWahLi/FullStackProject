class ProductTagsController < ApplicationController
  before_action :set_product_tag, only: %i[ show edit update destroy ]

  # GET /product_tags or /product_tags.json
  def index
    @product_tags = ProductTag.all
  end

  # GET /product_tags/1 or /product_tags/1.json
  def show
  end

  # GET /product_tags/new
  def new
    @product_tag = ProductTag.new
  end

  # GET /product_tags/1/edit
  def edit
  end

  # POST /product_tags or /product_tags.json
  def create
    @product_tag = ProductTag.new(product_tag_params)

    respond_to do |format|
      if @product_tag.save
        format.html { redirect_to product_tag_url(@product_tag), notice: "Product tag was successfully created." }
        format.json { render :show, status: :created, location: @product_tag }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @product_tag.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /product_tags/1 or /product_tags/1.json
  def update
    respond_to do |format|
      if @product_tag.update(product_tag_params)
        format.html { redirect_to product_tag_url(@product_tag), notice: "Product tag was successfully updated." }
        format.json { render :show, status: :ok, location: @product_tag }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @product_tag.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /product_tags/1 or /product_tags/1.json
  def destroy
    @product_tag.destroy

    respond_to do |format|
      format.html { redirect_to product_tags_url, notice: "Product tag was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product_tag
      @product_tag = ProductTag.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def product_tag_params
      params.require(:product_tag).permit(:product_id, :tag_id)
    end
end
