require 'charity_search'

class NonProfitController < ApplicationController

  def index
    @non_profits = NonProfit.all
  end

  def search
    respond_to do |format|
      format.html
    end
  end

  # FIXME: PLEASE give proper function name!
  def show_searched
    array = CharitySearch.get_non_profit_info(params[:non_profit][:name])
    @non_profits =  []
    non_profits_uuid = []
    array.each do |np|
      @non_profits << "#{np['primary_name']}, #{np['city']}"
      non_profits_uuid << "#{uuid['charity_uuid']}"
    end
    session[:non_profits] = non_profits_uuid 
    respond_to do |format|
      format.js 
    end
  end

  def register
    if request.post? and params[:non_profit]
      @non_profit = NonProfit.new(params[:non_profit])
      @non_profit.build_location
      if @non_profit.save
        flash[:notice] = "User #{@non_profit.username} created"
        redirect_to  :action => :login
      end
    else
      id = params[:id].to_i - 1
      non = session[:non_profits]
      non = non[id]
      @non_profit = NonProfit.new
      @non_profit.build_location 
      charity = CharitySearch.get_non_profit_uuid(non).first
      @non_profit.name = charity['primary_name']
      @non_profit.EIN = charity['ein']
      @non_profit.uuid = charity['charity_uuid']
      @non_profit.mission_statement   = charity['mission_statement']
      @non_profit.description = charity['ntee_data'].blank? ? '' : charity['ntee_data']['description']
      @non_profit.location.city = charity['city']
      @non_profit.location.state = charity['state']
      @non_profit.location.zip = charity['zip']
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
    @non_profit = NonProfit.find(params[:id])  
    if request.post? 
      @non_profit.update_attributes(:password => params[:non_profit][:password],:password_confirmation => params[:non_profit][:password_confirmation])
      if @non_profit.save
        flash[:message] = "Password Changed"
        redirect_to(:action => 'login')
      else
        flash[:message] = "Invalid"
        redirect_to(:action => 'register')
      end
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
