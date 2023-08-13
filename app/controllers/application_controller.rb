class ApplicationController < ActionController::Base
  protect_from_forgery prepend: true
  # before_action :authenticate_user!
  before_action :update_allowed_parameters, if: :devise_controller?

  # rescue_from CanCan::AccessDenied do |exception|
  #   redirect_to root_url, alert: exception.message
  # end

  protected

  def update_allowed_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |u|
      u.permit(:name, :email, :password, :password_confirmation)
    end
    devise_parameter_sanitizer.permit(:sign_in) { |u| u.permit(:email, :password) }
  end

  private

  def after_sign_in_path_for(_resource)
    groups_path # Redirect to groups index after sign-in
  end
end
