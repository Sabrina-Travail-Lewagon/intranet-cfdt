class RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters
  # GET /users/sign_up
  def new
    super
  end

  # POST /users
  def create
    # Votre code personnalisé ici
    super
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :photo])
  end
end
