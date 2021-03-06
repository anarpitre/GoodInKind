class ServicesController < ApplicationController
  
  before_filter :authenticate_user!, :only => [:edit, :thankyou, :invite_friends, :service_detail]
  before_filter :set_seo_tags
  before_filter :get_service_by_id, :only => [:update, :destroy, :show, :edit, :invite_friends, :remove, :service_detail, :offer_again]
  before_filter :is_owner, :only => [:edit, :service_detail, :invite_friends, :offer_again]

  autocomplete :nonprofit, :name, :full => true, :scopes => [:verified]

  layout 'service'

  def index
    @head[:title] = "Find services to buy in Ithaca, NY and support a non-profit cause"
    @services = Service.active.by_date.by_public.includes([:images, {:nonprofit => :nonprofit_categories}, :service_categories])
  end

  def show
    if @service.is_valid_service
      @head[:title] = @service.title + " for " + @service.nonprofit.name 
      @review = @service.reviews.build
      @reviews = Review.get_reviews(@service.group_number)
    else
      flash[:notice] = 'This service has been removed or has expired'
      redirect_to '/'
    end
  end

  def new
    @btn_text = "Offer it!"
    @head[:title] = "offer a service to support your non-profit cause"
    @service = Service.new
    build_objects
    @service.nonprofit_id = params[:id] unless params[:id].blank?
    requested_service unless params[:request_id].blank?
  end

  def newoffer
    @service = Service.new(:title => params[:title] == params[:suggest] ? "" : params[:title])
    build_objects
    render :action => 'new'
  end

  def requested_service
    req = Request.find(params[:request_id])
    @service.attributes = {"title" => req.title, "description" => req.description, :category_ids => [req.category_id]} 
    @service.location.address = req.location.address if req.location
    @service.request_id = req.id
  end

  def edit
    @btn_text = "Save"
    if @service.is_valid_service
      @head[:title] = "Edit Service"
      build_objects
    else
      flash[:notice] = 'This service has been removed or has expired'
      redirect_to '/'
    end
  end

  def create
    begin
      @btn_text = "Offer it!"
      @head[:title] = "offer a service to support your non-profit cause"
      params[:service].delete(:nonprofit_name)
      params[:service][:booking_capacity] = 0 if params[:service][:booking_capacity] == ""
      @service = Service.new(params[:service])
      @service.title = @service.title.humanize
      add_user_id                                                             
      @service.save!
      if current_user.blank?               
        session[:service_id] = @service.id 
        #if user is not siggned in than service id is stored in session  
        redirect_to new_user_session_path 
      else 
        @service.activate!
        send_new_service_message(@service)
        redirect_to thankyou_services_path 
      end
    rescue 
      @service.errors.delete(:"images.image")
      build_objects
      render :action => "new" 
    end
  end

  def update
    begin
      @btn_text = "Save"
      @head[:title] = "Edit Service"
      params[:service].delete(:nonprofit_name)
      params[:service][:booking_capacity] = 0 if params[:service][:booking_capacity] == ""
      @service.update_attributes!(params[:service])
      flash[:notice] = 'Service was successfully updated.'
      if @service.user == current_user
        redirect_to @service 
      else
        redirect_to admin_services_path
      end
    rescue 
      build_objects
      render :action => "edit", :id => @service.id 
    end
  end


  def thankyou
    @message = "Thank you for posting your offer!"
    session[:invite_friends] = false
    @service = !@service.blank? ? @service : current_user.services.first
    if @service.blank?
      redirect_to "/"
    end
  end

  def invite_friends
    @message = "Invite friends" 
    session[:invite_friends] = true
    session[:refered_from] = request.env['HTTP_REFERER'] 
    render :action => 'thankyou'
  end

  #Remove service
  def remove
    @service.remove!
    redirect_to services_profile_path(current_user)
  end
  
  def search
    @services = []

    unless params[:text].blank?
      result = INDEX.search(params[:text], :category_filters => {:type => 'service'})['results']
      ids = result.collect { |elem| elem['docid'].split(':').last.to_i }
      @services = Service.active.by_public.where(['id in (?)', ids]) unless ids.empty?
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
    @service = review.service
    review.user_id = current_user.id
    review.group_number = @service.group_number
    review.save(false)
    @reviews = Review.get_reviews(@service.group_number)
    respond_to do |format|
      format.js {render :layout=>false}
    end
  end

  def send_invitation
    emails = params[:users][:email]
    message = params[:users][:message]
    emails = emails.split(',')
    unless emails.blank?
      emails.each do |email|
        name = get_user_name(current_user.profile)
        offerer_email= "#{name}<#{current_user.email}>"
        Notifier.service_invitation(email,message,offerer_email).deliver
      end
      flash[:notice] = "Email was sent successfully!!"
      unless session[:invite_friends]
        redirect_to service_path(current_user.services.last)  
      else
        redirect_to session[:refered_from]  
        #redirect_to services_profile_path(current_user)  
      end
    else
      flash[:notice] = "Please add email to which invitations is to be sent!!!"
      redirect_to thankyou_services_path 
    end
  end

  def service_detail
    @user = current_user
    @transactions = @service.bookings.success.includes([:user => :profile], [:service => :reviews], :transaction).order("created_at DESC")
    @transactions = @transactions.paginate(:per_page => PER_PAGE_RECORDS, :page => params[:page])
    respond_to do |format|
      format.html 
      format.js
    end
  end

  def offer_again
    new_service = @service.clone
    category_ids = @service.service_categories.collect(&:category_id)
    new_service.attributes = {"donated_amount"=>"", "created_at"=>"", "updated_at"=>"", "request_id"=>"", "total_transactions"=>"", "permalink"=>"" ,:category_ids => category_ids }
    new_service.build_location(:address => @service.location.address) unless @service.is_virtual 
    new_service.images.build
    @service = new_service
    render :action => 'new'
  end

  def notify_owner
    service = Service.find_by_id(params[:id])
    email = service.user.email
    Notifier.notify_owner(email, service).deliver
    render :nothing => true
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
    unless user == current_user or is_admin?
      flash[:notice] = "You do not have sufficent privileges."
      redirect_to service_path(@service) 
    end    
  end

end
