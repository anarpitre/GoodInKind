class ProfilesController < ApplicationController
  before_filter :authenticate_user!, :only => [:edit, :index]
  before_filter :get_user
  before_filter :is_owner, :only => [:edit]
  
  layout "service"

  def index
    @profile = @user.profile
  end

  def edit
    @profile = @user.profile
    @profile.build_location if @profile.location.blank?
  end

  def update
    @profile = @user.profile
    @profile.attributes = params[:profile]
    if @profile.save 
      redirect_to profile_path(@user) 
    else
      render :action => :edit
    end
  end

  def show
    @profile = @user.profile 
    @services = Service.by_public.by_user(@profile.user_id)
    @reviews = Review.for_user(@user.id).limit(3)
  end

  def reviews
    @reviews = Review.for_user(@user.id)
    respond_to do |format|
      format.js {render :partial => 'reviews'}
    end
  end

  private

  def is_owner
    unless @user == current_user
      flash[:notice] = "You do not have sufficent privileges."
      redirect_to profile_path(@user) 
    end    
  end

end
