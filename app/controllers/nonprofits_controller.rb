class NonprofitsController < ApplicationController
  before_filter :set_seo_tags
  layout 'service'
  
  
  def index
    @head[:title] = "NP Home"
    @non_profits = NonProfit.all
  end

  def new
    @head[:title] = "Register"
    @non_profit = NonProfit.new
    @non_profit.build_location
  end
  
  def create
    @head[:title] = "Register"
    @non_profit = NonProfit.new(params[:non_profit])
    @non_profit.build_location
    if @non_profit.save
      flash[:notice] = "User #{@non_profit.username} created"
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
    authorized_user = NonProfit.authenticate(params[:username],params[:password])
    if authorized_user
      session[:non_profit_user_id] = authorized_user.id
      session[:non_profit_username] = authorized_user.username
      flash[:notice] = "You are now Logged In"
      redirect_to :action => 'index' 
    else
      flash[:notice] = "Invalid Username/Password"
      redirect_to :action => 'login'
    end
  end

  def change_password
    @non_profit = NonProfit.find(params[:nonprofit_id])  
    if request.post? 
      @non_profit.update_attributes(:password => params[:non_profit][:password],:password_confirmation => params[:non_profit][:password_confirmation])
      if @non_profit.save
        flash[:message] = "Password Changed"
        redirect_to(:action => 'login')
      else
        flash[:message] = "Invalid"
        redirect_to :action => 'change_password'
      end
    end
  end

  def logout
    session[:non_profit_user_id] = nil 
    session[:non_profit_username] = nil
    flash[:notice] = "You have been Logged Out"
    redirect_to '/'
  end
  
  def set_seo_tags
    @head = {
      :title => "Home",
      :keywords => "a b c d",
      :description => 'this is awesome'
    }
  end

end
