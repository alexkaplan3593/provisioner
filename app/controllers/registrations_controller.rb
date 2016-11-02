class RegistrationsController < Devise::RegistrationsController
	layout "simple"

  def new
  	super
  end

  # def create
  #   super
  # end
end