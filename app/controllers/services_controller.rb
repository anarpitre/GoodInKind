class ServicesController < ApplicationController

  autocomplete :non_profit, :name, :full => true
  layout 'service'

  def index
    @services = Service.all
  end

  def show
    @service = Service.find(params[:id])
  end

  def new
    @service = Service.new
    build_objects
  end

  def edit
    @service = Service.find(params[:id])
    build_objects
  end

  def create
    begin
      @service = Service.create!(params[:service])
      redirect_to(@service, :notice => 'Service was successfully created.') 
    rescue 
      render :action => "new" 
    end
  end

  def update
    begin
      @service = Service.find(params[:id])
      @service.update_attributes(params[:service])
      redirect_to(@service, :notice => 'Service was successfully updated.') 
    rescue 
      render :action => "edit", :id => @service.id 
    end
  end
  
  def build_objects
    @service.build_location if @service.location.blank?
    @service.images.build if @service.images.blank?
    @service.categories.build if @service.categories.blank?
  end

  def destroy
    @service = Service.find(params[:id])
    @service.destroy
  end

end
