class ProductsController < GridController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :edit, :update, :destroy]
  before_action :get_tags, only: [:new, :show, :edit, :update, :destroy]

  respond_to :html, :js, :json
  # GET /products
  # GET /products.json

  ## Infinite Scroll is based on : https://www.sitepoint.com/infinite-scrolling-rails-basics/
  def index
    @products = Product.paginate(page: params[:page], per_page: 12).order('created_at DESC')
    respond_to do |format|
      format.html
      format.js
    end
  end

  def viewlist
    @products = Product.all
  end

  # GET /products/1
  # GET /products/1.json
  def show
    @related_tags_id = @product.tags.present? ? @product.tags.first.assoc_tags : nil
    if @related_tags_id.present?
      @related_tag =  Tag.find(@related_tags_id)
      @related = Tag.find(@related_tags_id).products.limit(5)
    end
    render "products/show", :layout => false
  end

  def recent
    @products = Product.paginate(page: params[:page], per_page: 12).order('created_at ASC')
    render :index
  end

  def hot
    @products = Product.paginate(page: params[:page], per_page: 12).order('created_at DESC')
    render :index
  end

  def most_to_least
    @products = Product.paginate(page: params[:page], per_page: 12).order('price DESC')
    render :index
  end

  def least_to_most
    @products = Product.paginate(page: params[:page], per_page: 12).order('price ASC')
    render :index
  end

  def prime
    @products = Product.paginate(page: params[:page], per_page: 12).where(:prime => true)
    render :index
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to products_path, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def get_amazon
    response = Product.get_amazon_info(params[:product_id])
    render json: response.body
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.friendly.find(params[:id])
    end

    def get_tags
      @tags = Tag.all
    end


    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:price, :name, :prime,:image, :vendor, :discoverer, :url, {:tag_ids=> []})
    end

end
