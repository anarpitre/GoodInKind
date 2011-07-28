class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def after_sign_in_path_for(scope)
    if scope.is_a?(User)
      dashboard_index_path(current_user.id)
    else
      super
    end
  end
 
end
