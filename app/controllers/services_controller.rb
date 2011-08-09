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
      @service = Service.new(params[:service])
      get_non_profit_id
      @service.save!
      redirect_to(@service, :notice => 'Service was successfully created.') 
    rescue 
      build_objects
      render :action => "new" 
    end
  end

  def update
    begin
      @service = Service.find(params[:id])
      @service.update_attributes(params[:service])
      get_non_profit_id
      @service.save!
      redirect_to(@service, :notice => 'Service was successfully updated.') 
    rescue 
      render :action => "edit", :id => @service.id 
    end
  end
  
  def build_objects
    @service.build_location if @service.location.blank?
    @service.images.build if @service.images.blank?
    @service.categories.build if @service.categories.blank?
    @service.build_service_non_profit if @service.service_non_profit.blank?
  end

  def get_non_profit_id
    non_profit = NonProfit.find_by_name(params[:service][:service_non_profit_attributes][:non_profit_id])
    @service.service_non_profit.non_profit_id = non_profit.id unless non_profit.blank?
  end

  def destroy
    @service = Service.find(params[:id])
    @service.destroy
  end

end
