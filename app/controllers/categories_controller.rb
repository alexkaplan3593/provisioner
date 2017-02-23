class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy]

  respond_to :html, :js

  def index
    @categories = Category.order('category_name ASC')

  end

  def show
    @products = Product.where(:category_id => params[:id])

  end

  def new
    @category = Category.new
    respond_with(@category)
  end

  def edit
  end

  def create
    @category = Category.new(category_params)

    if params[:category][:image].present?
      preloaded = Cloudinary::PreloadedFile.new(params[:category][:image])         
      raise "Invalid upload signature" if !preloaded.valid?
      puts preloaded.identifier
      @category.image = preloaded.identifier
    end

    @category.save
    respond_with(@category)
  end

  def update
    @category.update(category_params)

    if params[:category][:image].present?
      preloaded = Cloudinary::PreloadedFile.new(params[:category][:image])         
      raise "Invalid upload signature" if !preloaded.valid?
      puts preloaded.identifier
      @category.image = preloaded.identifier
    end

    @category.save

    respond_with(@category)
  end

  def destroy
    @category.destroy
    respond_with(@category)
  end

  private
    def set_category
      @category = Category.friendly.find(params[:id])
    end

    def category_params
      params.require(:category).permit(:category_name, :image, :slug)
    end
end
