class ProfilesController < ApplicationController
 
  layout "service"

  def index

  end

  def edit
    @profile = current_user.profile
    @profile.build_location if @profile.location.blank?
  end

  def update
    begin 
      profile = current_user.profile
      profile.attributes = params[:profile]
      profile.save
      redirect_to :action => 'index'
    rescue
      @profile.build_location if @profile.location.blank?
      redirect_to :action => 'edit'
    end
  end

end
