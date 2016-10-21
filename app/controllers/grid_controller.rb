 class GridController < ApplicationController

  def least_to_most

  	if params[:tag_id].present?
  		@tag = Tag.find_by_id(params[:tag_id])
  		@products = @tag.products.order(price: :asc)
  	else
  		@products = Product.order(price: :asc)
  	end
  	render :template => "products/viewlist"
  end

  def most_to_least
  	if params[:tag_id].present?
  		@tag = Tag.find_by_id(params[:tag_id])
  		@products = @tag.products.order(price: :desc)
  	else
  		@products = Product.order(price: :desc)
  	end
  	render :template => "products/viewlist"
  end

end