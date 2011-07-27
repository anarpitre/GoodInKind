class NonProfitController < ApplicationController

#  before_filter :confirm_logged_in , :except => [:login,:register,:attempt_login,:logout]

  def index
    register
    render('register')
  end

  def register
    if request.post? and params[:non_profit]
    @non_profit = NonProfit.new(params[:non_profit])
      if @non_profit.save
        flash[:notice] = "User #{@non_profit.username} created"
        redirect_to  :action => :login
      end
      puts @non_profit.errors.full_messages
    end
  end
  
  def login
  end

  def attempt_login
    authorized_user = NonProfit.authenticate(params[:username],params[:password])
    if authorized_user
      session[:non_profit_user_id] = authorized_user.id
      session[:non_profit_username] = authorized_user.username
      flash[:notice] = "Yu are now Logged In"
      puts "Successful Loggin"
      redirect_to(:action => 'change_password', :id => authorized_user.id)
    else
      flash[:notice] = "Invalid Username/Password"
      puts "UnSuccesful"
      render(:text => 'Invalid Username/Password')
    end

  end

  def change_password
    @non_profit = NonProfit.find_by_permalink(params[:id])  
    if request.post? 
      @non_profit.update_attributes(:password => params[:non_profit][:password],:password_confirmation => params[:non_profit][:password_confirmation])
      if @non_profit.save
        flash[:message] = "Password Changed"
        redirect_to(:action => 'login')
      else
        flash[:message] = "Invalid"
        redirect_to(:action => 'register')
      end
      puts @non_profit.errors.full_messages
    end
  end

  def logout
    session[:non_profit_user_id] = nil 
    session[:non_profit_username] = nil
    flash[:notice] = "You have been Logged Out"
    redirect_to(:action => 'login')
  end

  private

  def confirm_logged_in
    unless session[:user_id]
      flash[:notice] = "Please Log IN"
      redirect_to(:action => :login)
      return false
    else
      return true
    end
  end

end
