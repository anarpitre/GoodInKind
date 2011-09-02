class ProfilesController < ApplicationController
  
  before_filter :authenticate_user!, :only => [:edit, :index]
  before_filter :is_owner, :only => [:edit]
  
  layout "service"

  def index
    @profile = current_user.profile
  end

  def edit
    @profile = current_user.profile
    @profile.build_location if @profile.location.blank?
  end

  def update
    begin 
      @profile = current_user.profile
      @profile.attributes = params[:profile]
      @profile.save!
      redirect_to :action => 'index'
    rescue 
      @profile.build_location if @profile.location.blank?
      render :action => 'edit'
    end
  end

  def show
    @profile = User.find(params[:id]).profile
    @services = Service.by_public.by_user(@profile.user_id)
  end

  private

  def is_owner
    user = User.find(params[:id]) 
    unless user == current_user
      flash[:notice] = "You do not have sufficent privileges."
      redirect_to profile_path(user) 
    end    
  end

end
