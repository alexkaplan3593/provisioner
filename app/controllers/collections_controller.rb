class CollectionsController < ApplicationController
  before_action :set_collection, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @collections = Collection.all
    if params[:tags]
      puts "we have tags"
    end
    respond_with(@collections)
  end

  def build
    @products = Product.all 
  end

  def show
    respond_with(@collection)
  end

  def new
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
      @collection = Collection.find(params[:id])
    end

    def collection_params
      params.require(:collection).permit(:product_id, :user_id, :collection_name, :tags)
    end
end
