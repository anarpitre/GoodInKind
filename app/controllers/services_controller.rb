class ServicesController < ApplicationController

  layout 'service'

  def index
    @services = Service.all
  end

  def show
    @service = Service.find(params[:id])
  end

  def new
    @service = Service.new
    @service.build_location
    @service.images.build
    @non_profits = NonProfit.all
  end

  def edit
    @service = Service.find(params[:id])
    @service.build_location unless @service.location.blank?
    @service.images.build unless @service.images.blank?
  end

  def create
    @service = Service.new(params[:service])

    if @service.save
      redirect_to(@service, :notice => 'Service was successfully created.') 
    else
      @non_profits = NonProfit.all
      render :action => "new" 
    end
  end

  def update
    @service = Service.find(params[:id])

    if @service.update_attributes(params[:service])
      redirect_to(@service, :notice => 'Service was successfully updated.') 
    else
      render :action => "edit" 
    end
  end

  def destroy
    @service = Service.find(params[:id])
    @service.destroy
  end
end
