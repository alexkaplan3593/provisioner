class TagsController < GridController
  before_action :set_tag, only: [:show, :edit, :update, :destroy, :most_to_least, :least_to_most,  :recent, :hot, :prime]
  before_action :set_tags, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @tags = Tag.all
    respond_with(@tags)
  end

  def show
    @products = @tag.products
    respond_with(@tag)
  end

  def new
    @tag = Tag.new
    respond_with(@tag)
  end

  def edit
  end

  def create
    @tag = Tag.new(tag_params)
    @tag.save
    respond_with(@tag)
  end

  def update
    @tag.update(tag_params)
    respond_with(@tag)
  end

  def recent
    @products = Product.includes(:tags).where(:tags => {:id => params[:tag_id]}).paginate(page: params[:page], per_page: 4).order('products.created_at ASC')
    render "products/viewlist"
  end

  def hot
    @products = Product.includes(:tags).where(:tags => {:id => params[:tag_id]}).paginate(page: params[:page], per_page: 4).order('products.created_at DESC')
    render "products/viewlist"
  end

  def most_to_least
    @products = Product.includes(:tags).where(:tags => {:id => params[:tag_id]}).paginate(page: params[:page], per_page: 4).order('price DESC')

    render "products/viewlist"
  end

  def least_to_most
    @products = Product.includes(:tags).where(:tags => {:id => params[:tag_id]}).paginate(page: params[:page], per_page: 4).order('price ASC')
    render "products/viewlist"
  end

  def prime
    @products = Product.where(:prime => true)
    render "products/viewlist"
  end

  def destroy
    @tag.destroy
    respond_with(@tag)
  end

  private
    def set_tag
      if params[:id]
        @tag = Tag.friendly.find(params[:id])
      else
        @tag = Tag.friendly.find(params[:tag_id])
      end
    end

    def set_tags
      @tags = Tag.all
    end

    def tag_params
      params.require(:tag).permit(:tag_name, :product_usage, :assoc_tags, :image, :display, :tag_type)
    end
end
