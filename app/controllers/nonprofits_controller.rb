class NonprofitsController < ApplicationController
  before_filter :set_seo_tags
  before_filter :get_nonprofit, :except => [:new, :create, :login, :create_session]
  before_filter :nonprofit_owner, :only => [:edit, :logout, :change_password]

  layout 'nonprofit'
  
  def index
    @head[:title] = "NonProfit Home"
    @nonprofits = Nonprofit.verified
  end

  def show
    @head[:title] = @nonprofit.name
  end
  
  def new
    @head[:title] = "NonProfit"
    @nonprofit = Nonprofit.new
  end

  def edit
    @nonprofit = Nonprofit.find(params[:id])
  end
  
  def create
    @nonprofit.build_location unless @nonprofit.location
    @head[:title] = @nonprofit.name
  end
  
  def create
    @nonprofit = Nonprofit.new(params[:nonprofit])
    if @nonprofit.save
      flash[:notice] = "User #{@nonprofit.username} created"
      redirect_to  :action => 'login'
    else
      render :action => 'new'
    end
  end

  def update
    if @nonprofit.update_attributes(params[:nonprofit])
      flash[:notice] = "User #{@nonprofit.username} updated"
      redirect_to  nonprofit_path(@nonprofit)
    else
      render :action => 'edit'
    end
  end
  
  def login
    @head[:title] = "NonProfit Login"
  end
  
  def create_session 
    @nonprofit = Nonprofit.authenticate(params[:username],params[:password])
    if @nonprofit
      session[:nonprofit] = {}
      session[:nonprofit][:name] = @nonprofit.name
      session[:nonprofit][:id] = @nonprofit.id
      flash[:notice] = "You are now Logged In"
      redirect_to nonprofit_path(@nonprofit)
    else
      flash[:notice] = "Invalid Username/Password"
      redirect_to :action => 'login'
    end
  end

  def change_password
    if request.post? 
      @nonprofit.update_attributes(:password => params[:nonprofit][:password],
                 :password_confirmation => params[:nonprofit][:password_confirmation])
      if @nonprofit.save
        flash[:message] = "Password Changed"
        redirect_to(:action => 'login')
      else
        flash[:message] = "Invalid"
        redirect_to :action => 'change_password'
      end
    end
    # GET: render form
  end

  def logout
    session[:nonprofit] = nil
    flash[:notice] = "You have been Logged Out"
    redirect_to root_path
  end
  
  private

  def get_nonprofit
    id = (params and params[:id]) || (session[:nonprofit] and session[:nonprofit][:id])
    @nonprofit = Nonprofit.find(id) if id
  end

  def set_seo_tags
    @head = {
      :title => "Non Profits Home",
      :keywords => "NonProfits, Charities, NGos",
      :description => 'Choose a non-profit organization below and support it by either purchasing '
    }
  end

  def nonprofit_owner
    return true if session and (session[:nonprofit][:id] == @nonprofit.id)
    redirect_to login_nonprofits_path
  end

end
