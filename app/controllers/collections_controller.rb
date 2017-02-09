class CollectionsController < ApplicationController
  before_action :set_collection, only: [:show, :edit, :update, :destroy]

  respond_to :html, :js

  def index
    @collections = Collection.where(:display => true)

    if params[:tags]
      tags = params[:tags]
      @products = Collection.generate_and_set_products(tags)
      render :show
    end

  end

  def gift_builder
      @person_tags = Tag.where(:tag_type => "person")
      @interest_tags = Tag.where(:tag_type => "interest")
      @activity_tags = Tag.where(:tag_type => "activity")
  end

  def build
    @products = Collection.generate_and_set_products(params[:tags])
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

    if params[:collection][:image].present?
      preloaded = Cloudinary::PreloadedFile.new(params[:collection][:image])         
      raise "Invalid upload signature" if !preloaded.valid?
      puts preloaded
      @collection.image = preloaded.identifier
    end

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
      params.require(:collection).permit(:product_id, :user_id, :image, :collection_name, :tags, :display)
    end
end
