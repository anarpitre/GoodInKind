class ProfilesController < ApplicationController
  def index
    @profile = current_user.profile || current_user.build_profile
    @authentications = current_user.authentications
  end

  def create
    #profile = current_user.profile || current_user.build_profile
    begin
    profile = Profile.find_by_user_id(current_user.id)
    if profile.blank?
      profile = Profile.new(:user_id => current_user.id)
    end
    profile.attributes = params[:profile]
    profile.save
    rescue Exception => e
      puts "######################################################"
      puts e
    end
    redirect_to :action => 'index'
  end

  def edit
  end

end
