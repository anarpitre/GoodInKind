class NonprofitsController < ApplicationController
  before_filter :set_seo_tags
  before_filter :get_nonprofit, :except => [:new, :create, :login, :create_session, :transactions]
  before_filter :nonprofit_owner, :only => [:edit, :logout, :change_password, :account, :transactions]

  layout 'nonprofit'
  
  def index
    @head[:title] = "NonProfit Home"
    @nonprofits = Nonprofit.all

    # FIXME: To add index-tank search on the following Nonprofit criteria:
    # name, EIN, category, mission, guideline, description, website
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
    logger.info(params[:nonprofit])
    @nonprofit = Nonprofit.new(params[:nonprofit])
    if @nonprofit.save
      flash[:notice] = "User #{@nonprofit.username} created"
      redirect_to  :action => 'login'
    else
      render :action => :new
    end
  end

  # Update gets called from /account and /edit page
  def update
    referer = session[:referer]

    if referer == 'account'
      # If old_password and password are not blank validate the old
      # password and if its correct, change it to the new one!
      unless (params[:old_password].blank? and params[:nonprofit][:password].blank?)
        if Nonprofit.authenticate(@nonprofit.username, params[:old_password]) and
           (params[:nonprofit][:password] == params[:nonprofit][:password_confirmation])

          # invoke private method!
          @nonprofit.send(:update_password, params[:nonprofit][:password]) 

          # remove these parameters from the params
          params.delete(:old_password)
          params[:nonprofit].delete(:password)
          params[:nonprofit].delete(:password_confirmation)
        else
            @nonprofit.errors.add(:password, "does not match")
            render :action => :account and return
        end
      end
    end
    if @nonprofit.update_attributes(params[:nonprofit])
      flash[:notice] = "User #{@nonprofit.username} updated"
      session[:referer] = nil # cleanup first!
      redirect_to  (referer == 'account' ? account_nonprofit_path(@nonprofit) : nonprofit_path(@nonprofit) )
    else
      render :action => referer
    end
  end

  def account
    # Maintain a session variable, to identify the referrer in update action
    session[:referer] = 'account'
  end

  def transactions
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
