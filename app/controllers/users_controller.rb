class UsersController < ApplicationController

  respond_to :html


  def show
    @user = User.find(params[:id])
		@products = @user.products.paginate(page: params[:page], per_page: 12).order('created_at DESC')
  end

  private
   
end
