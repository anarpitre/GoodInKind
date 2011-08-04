class ServicesController < ApplicationController

  def index
    @services = Service.all

    respond_to do |format|
      format.html 
      format.xml  { render :xml => @services }
    end
  end

  def show
    @service = Service.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @service }
    end
  end

  def new
    @service = Service.new
    @service.build_location
    @service.images.build

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @service }
    end
  end

  def edit
    @service = Service.find(params[:id])
    @service.build_location
    @service.images.build
  end

  def create
    @service = Service.new(params[:service])

    respond_to do |format|
      if @service.save
        format.html { redirect_to(@service, :notice => 'Service was successfully created.') }
        format.xml  { render :xml => @service, :status => :created, :location => @service }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @service.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @service = Service.find(params[:id])

    respond_to do |format|
      if @service.update_attributes(params[:service])
        format.html { redirect_to(@service, :notice => 'Service was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @service.errors, :status => :unprocessable_entity }
      end
    end
  end

  #def autocomplete_non_profit_name
   # term = params[:term]
    #if term && !term.empty?
    #  items = NonProfit.where(["LOWER(name) LIKE ?", "%#{term.downcase}%"]).limit(10).order("name ASC")
    #else
     # items = {}
    #end

  #nd

  def destroy
    @service = Service.find(params[:id])
    @service.destroy

    respond_to do |format|
      format.html { redirect_to(services_url) }
      format.xml  { head :ok }
    end
  end
end
