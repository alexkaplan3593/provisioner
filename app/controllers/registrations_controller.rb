class RegistrationsController < Devise::RegistrationsController
	layout "simple"

  def new
  	super
  end

  # def create
  #   super
  # end

  def sign_up_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end
end