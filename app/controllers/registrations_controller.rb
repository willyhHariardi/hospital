class RegistrationsController < Devise::RegistrationsController
  before_action :require_no_authentication, only: :new
  def after_sign_up_path_for(resource)
    sign_out resource
    sehatq_backyard_admin_index_path# Or :prefix_to_your_route
  end
end