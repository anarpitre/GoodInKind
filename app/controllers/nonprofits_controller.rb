class NonprofitsController < ApplicationController
  
  def index
    @non_profits = NonProfit.all
  end

  def login
  end
  
  def create_session 
    authorized_user = NonProfit.authenticate(params[:username],params[:password])
    if authorized_user
      session[:non_profit_user_id] = authorized_user.id
      session[:non_profit_username] = authorized_user.username
      flash[:notice] = "You are now Logged In"
      redirect_to '/'
    else
      flash[:notice] = "Invalid Username/Password"
      redirect_to :action => 'login'
    end
  end

  def register
    @non_profit = NonProfit.new
    @non_profit.build_location
  end

  def create
    @non_profit = NonProfit.new(params[:non_profit])
    @non_profit.build_location
    if @non_profit.save
      flash[:notice] = "User #{@non_profit.username} created"
      redirect_to  :action => 'login'
    else
      render :action => 'register'
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

end
