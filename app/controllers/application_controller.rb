class ApplicationController < ActionController::Base
  protect_from_forgery
   
  def my_home_path(user)
    user_profile_path(user.id)
  end

end
