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
      @service.save!
      redirect_to(@service, :notice => 'Service was successfully created.') 
    rescue 
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

  def set_seo_tags
    @head = {
      :title => "Service Home",
      :keywords => "Table Tennis Lesson, How to do beat boxing",
      :description => 'Offer a service to support your favourite NonProfits'
    }
  end
end
