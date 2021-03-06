class RequestsController < ApplicationController
  layout 'service'
  
  def index
    #@request = Request.all
    @request = Request.created
  end

  def new
    @request = Request.new
    @request.email = current_user.email unless current_user.blank?
    @request.build_location 
  end

  def create
    begin 
      @request = Request.new
      @request.attributes = params[:request]
      @request.save!
      Notifier.new_request(@request.email, @request.title).deliver
      redirect_to requests_path
    rescue
      @request.build_location if @request.location.blank?
      render :action => 'new'
    end
  end

  def show
    @request = Request.find(params[:id])
  end

end
