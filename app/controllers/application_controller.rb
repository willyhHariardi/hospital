class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    if admin_signed_in?
      sehatq_backyard_home_index_path
    else 
      root_path
    end
  end

  def after_sign_out_path_for(resource_or_scope)
    if resource_or_scope.eql?(:admin)
      admin_session_path
    else 
      # new_admin_session_path
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :email, :password)}
    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :email, :password, :current_password)}
  end
end
