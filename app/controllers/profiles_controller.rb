class ProfilesController < ApplicationController
 
  layout "service"

  def index
    @profile = current_user.profile || current_user.build_profile
    @authentications = current_user.authentications
  end

  def create
    profile = current_user.profile || current_user.build_profile
    profile.attributes = params[:profile]
    profile.save
    redirect_to :action => 'index'
  end

end
