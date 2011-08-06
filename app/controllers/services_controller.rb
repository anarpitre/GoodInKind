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
    @service.build_location
    @service.images.build
    @service.categories.build
    @non_profits = NonProfit.all
  end

  def edit
    @service = Service.find(params[:id])
    @service.build_location unless @service.location.blank?
    @service.images.build unless @service.images.blank?
    @service.categories.build unless @service.categories.blank?
  end

  def create
    begin
      params[:service][:non_profit] = NonProfit.find_by_name(params[:service][:non_profit])
      @service = Service.new(params[:service])
      @service.save!
      redirect_to(@service, :notice => 'Service was successfully created.') 
    rescue Exception => e
      @service.non_profit = nil
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
