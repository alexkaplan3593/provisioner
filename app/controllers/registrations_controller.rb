class RegistrationsController < Devise::RegistrationsController
	layout :resolve_layout

  def new
  	super
  end

  def resolve_layout
    case action_name
    when "new", "create","index"
      "simple"
    else
      "application"
    end
  end

  def sign_up_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end
end