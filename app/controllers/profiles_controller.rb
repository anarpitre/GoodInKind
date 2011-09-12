class ProfilesController < ApplicationController
  before_filter :authenticate_user!, :only => [:edit, :account, :services]
  before_filter :get_user
  before_filter :is_owner, :only => [:edit, :account, :services]
  
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
    unless @user == current_user
      @services = Service.by_public.by_user(@profile.user_id)
      @reviews = Review.for_user(@user.id).limit(3)
    end
  end

  def reviews
    @reviews = Review.for_user(@user.id)
    respond_to do |format|
      format.js {render :partial => 'reviews'}
    end
  end

  def services
    @services = @user.services.includes(:nonprofit)
    @bookings = @user.bookings.includes(:service)
  end

  def cancel_service
    service = Service.find(params[:id])
    service.update_attributes!(:status => "cancel")
    respond_to do |format|
      format.js {render :js => "$('#service_#{service.id}').remove();"}
    end
  end

  def account
    @profile = @user.profile
    if request.put?
      if @profile.update_attributes(params[:profile])
          flash[:notice] = "Account Updated Successfuly"
          redirect_to account_profile_path(@user) 
      end
    end
  end


end
