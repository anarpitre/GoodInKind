class ProfilesController < ApplicationController
  before_filter :authenticate_user!, :only => [:edit, :index]
  before_filter :get_user
  before_filter :is_owner, :only => [:edit]
  
  layout "service"

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
      if @profile.avatar_file_name_changed?
        @profile.avatar.instance_write(:file_name, @profile.avatar_file_name_change[0])
        @profile.avatar.instance_write(:file_size, @profile.avatar_file_size_change[0])
        @profile.avatar.instance_write(:content_type, @profile.avatar_content_type_change[0])
      end
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

  def services
  end

  private

  def is_owner
    unless @user == current_user
      flash[:notice] = "You do not have sufficent privileges."
      redirect_to profile_path(@user) 
    end    
  end

end
