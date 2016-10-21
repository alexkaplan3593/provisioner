class SessionsController < Devise::SessionsController
	layout "simple"

  def new
  	super
  end

  # def create
  #   super
  # end
end