class ServicesController < ApplicationController
  
  before_filter :get_service_by_id, :only => [:update, :destroy, :show, :edit]
  autocomplete :non_profit, :name, :full => true
  layout 'service'

  def index
    @services = Service.all
  end

  def show
  end

  def new
    @service = Service.new
    build_objects
  end

  def edit
    build_objects
  end

  def create
    begin
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

end
