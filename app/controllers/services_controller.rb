class ServicesController < ApplicationController
  before_filter :set_seo_tags
  before_filter :get_service_by_id, :only => [:update, :destroy, :show, :edit]
  
  autocomplete :nonprofit, :name, :full => true

  layout 'service'

  def index
    @head[:title] = "Service Home"
    @services = Service.all
  end

  def show
    @head[:title] = "My Service"
  end

  def new
    @head[:title] = "New Service"
    @service = Service.new
    build_objects
  end

  def edit
    @head[:title] = "Edit Service"
    build_objects
  end

  def create
    begin
      @head[:title] = "Create Service"
      @service = Service.new(params[:service])
      add_user_id                                                             
      @service.save!
      if current_user.blank?               
        session[:service_id] = @service.id                                      #if user is not siggned in than service id is stored in session  
        redirect_to(new_user_registration_path, :notice => 'Service was successfully created.') 
      else 
        @service.activate!
        redirect_to(thankyou_services_path, :notice => 'Service was successfully created.') 
      end
    rescue Exception => e 
      build_objects
      render :action => "new" 
    end
  end

  def update
    begin
      @head[:title] = "Update Service"
      @service.update_attributes!(params[:service])
      redirect_to(@service, :notice => 'Service was successfully updated.') 
    rescue 
      build_objects
      render :action => "edit", :id => @service.id 
    end
  end


  def thankyou
    @service = @service.blank? ? @service : current_user.service 
  end

  def build_objects
    @service.build_location if @service.location.blank?
    @service.images.build if @service.images.blank?
    @service.categories.build if @service.categories.blank?
  end

  def destroy
    @service.destroy
  end

  def get_service_by_id
    @service = Service.find(params[:id])
  end

  #Add temporary_user_id if user is not siggned in  else add current_user_id 
  def add_user_id
    @service.user_id = !current_user.blank? ? current_user.id : User.get_dummy_user.first.id
  end

  def browse_nonprofit
    @nonprofit = Nonprofit.all
    render :layout => nil
  end

  def set_seo_tags
    @head = {
      :title => "Service Home",
      :keywords => "Table Tennis Lesson, How to do beat boxing",
      :description => 'Offer a service to support your favourite NonProfits'
    }
  end
end
