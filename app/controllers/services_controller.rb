class ServicesController < ApplicationController
  
  before_filter :authenticate_user!, :only => [:edit, :thankyou]
  before_filter :set_seo_tags
  before_filter :get_service_by_id, :only => [:update, :destroy, :show, :edit]
  before_filter :is_owner, :only => [:edit]

  autocomplete :nonprofit, :name, :full => true, :scopes => [:verified]

  layout 'service'

  def index
    @head[:title] = "Service Home"
    @services = Service.by_public.includes([:images, {:nonprofit => :nonprofit_categories}, :service_categories])
  end

  def show
    @head[:title] = "My Service"
    @review = @service.reviews.build
    @reviews = Review.get_reviews(@service.id)
  end

  def new
    @head[:title] = "New Service"
    @service = Service.new
    build_objects
    @service.nonprofit_id = params[:id] unless params[:id].blank?
    requested_service unless params[:request_id].blank?
  end

  def newoffer
    @service = Service.new(:title => params[:title])
    build_objects
    render :action => 'new'
  end

  def requested_service
    req = Request.find(params[:request_id])
    @service.attributes = {"title" => req.title, "description" => req.description} 
    @service.location.address = req.location.address if req.location
    @service.request_id = req.id
  end

  def edit
    @head[:title] = "Edit Service"
    build_objects
  end

  def create
    begin
      @head[:title] = "Create Service"
      params[:service].delete(:nonprofit_name)
      start_date = params[:service].delete(:start_date)
      end_date = params[:service].delete(:end_date)
      @service = Service.new(params[:service])
      @service.start_date = DateTime.strptime(start_date, "%m/%d/%Y") unless start_date.blank?
      @service.end_date = DateTime.strptime(end_date, "%m/%d/%Y") unless end_date.blank?
      @service.title = @service.title.humanize
      add_user_id                                                             
      @service.save!
      if current_user.blank?               
        session[:service_id] = @service.id 
        #if user is not siggned in than service id is stored in session  
        redirect_to(new_user_session_path, :notice => 'You need to signin/signup before posting the service') 
      else 
        @service.activate!
        redirect_to(thankyou_services_path, :notice => 'Service was successfully created.') 
      end
    rescue 
      build_objects
      render :action => "new" 
    end
  end

  def update
    begin
      @head[:title] = "Update Service"
      params[:service].delete(:nonprofit_name)
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
  
  def search
    @services = []
    unless params[:text].blank?
      result = INDEX.search(params[:text]) 
      unless result['matches'] == 0
        result['matches'].times do |i|
          arr = result['results'][i]['docid'].split(':')
          if arr.first == "Service"
            service = Service.find(arr.last.to_i)
            @services << service if service.status == 'active' && service.is_public == true
          end
        end
        @services.flatten!
      end
    end
    render 'index'
  end

  def destroy
    @service.destroy
  end

  def browse_nonprofit
    @nonprofit = Nonprofit.verified
    render :layout => nil
  end

  def review
    review = Review.new(params[:review])
    review.user_id = current_user.id
    review.group_number = review.service.group_number
    review.save(false)
    @reviews = Review.get_reviews(review.service.id)
    respond_to do |format|
      format.js {render :layout=>false}
    end
  end
  
  private

  def build_objects
    @service.build_location if @service.location.blank?
    @service.images.build if @service.images.blank?
    @service.categories.build if @service.categories.blank?
  end

  def get_service_by_id
    @service = Service.find(params[:id])
  end

  #Add temporary_user_id if user is not siggned in  else add current_user_id 
  def add_user_id
    @service.user_id = !current_user.blank? ? current_user.id : User.get_dummy_user.first.id
  end

  def set_seo_tags
    @head = {
      :title => "Service Home",
      :keywords => "Table Tennis Lesson, How to do beat boxing",
      :description => 'Offer a service to support your favourite NonProfits'
    }
  end
  
  def is_owner
    user = @service.user  
    unless user == current_user
      flash[:notice] = "You do not have sufficent privileges."
      redirect_to service_path(@service) 
    end    
  end

end
