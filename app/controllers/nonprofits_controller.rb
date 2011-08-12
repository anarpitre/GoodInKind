class NonprofitsController < ApplicationController
  before_filter :set_seo_tags
  layout 'nonprofit'
  
  def index
    @nonprofits = Nonprofit.all
  end

  def show
    @nonprofit = Nonprofit.find(params[:id])
    @head[:title] = @nonprofit.name
  end
  
  def new
    @head[:title] = "Register"
    @nonprofit = Nonprofit.new
    @nonprofit.build_location
  end

  def edit
    @nonprofit = Nonprofit.find(params[:id])
  end
  
  def create
    @head[:title] = "Register"
    @nonprofit = Nonprofit.new(params[:nonprofit])
    @nonprofit.build_location
    if @nonprofit.save
      flash[:notice] = "User #{@nonprofit.username} created"
      redirect_to  :action => 'login'
    else
      render :action => 'new'
    end
  end
  
  def login
    @head[:title] = "Login"
  end
  
  def create_session 
    @head[:title] = "Login"
    authorized_user = Nonprofit.authenticate(params[:username],params[:password])
    if authorized_user
      session[:nonprofit_user_id] = authorized_user.id
      session[:nonprofit_username] = authorized_user.username
      flash[:notice] = "You are now Logged In"
      redirect_to :action => 'index' 
    else
      flash[:notice] = "Invalid Username/Password"
      redirect_to :action => 'login'
    end
  end

  def change_password
    @nonprofit = Nonprofit.find(params[:nonprofit_id])  
    if request.post? 
      @nonprofit.update_attributes(:password => params[:nonprofit][:password],:password_confirmation => params[:nonprofit][:password_confirmation])
      if @nonprofit.save
        flash[:message] = "Password Changed"
        redirect_to(:action => 'login')
      else
        flash[:message] = "Invalid"
        redirect_to :action => 'change_password'
      end
    end
  end

  def logout
    session[:nonprofit_user_id] = nil 
    session[:nonprofit_username] = nil
    flash[:notice] = "You have been Logged Out"
    redirect_to '/'
  end
  
  def set_seo_tags
    @head = {
      :title => "Non Profits",
      :keywords => "a b c d",
      :description => 'this is awesome'
    }
  end

end
