class CollectionsController < ApplicationController
  before_action :set_collection, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @collections = Collection.all

    @products = []
    @collection_tags = []

    if params[:tags]
      tags = params[:tags]

      tags.each do |tag|
        puts 'tag is ' + tag.to_s
        @final_tag = Tag.where("LOWER(tag_name) = ?", tag).first
        puts @final_tag.id
        if @final_tag.present?
          @collection_tags << @final_tag.tag_name
         @products += @final_tag.products
        end

      end
      render :show
    end
  end

  def gift_builder

  end

  def build
    @products = Product.all 
  end

  def show
    @tags = @collection.tags
    @products = []

    @tags.each do |tag|
      @products += tag.products
    end

  end

  def new
    @tags = Tag.all
    @collection = Collection.new
    respond_with(@collection)
  end

  def edit
  end

  def create
    @collection = Collection.new(collection_params)
    @collection.save
    respond_with(@collection)
  end

  def update
    @collection.update(collection_params)
    respond_with(@collection)
  end

  def destroy
    @collection.destroy
    respond_with(@collection)
  end

  private
    def set_collection
      @collection = Collection.friendly.find(params[:id])
    end

    def collection_params
      params.require(:collection).permit(:product_id, :user_id, :image, :collection_name, :tags)
    end
end
