class NonprofitsController < ApplicationController
  before_filter :set_seo_tags
  before_filter :get_nonprofit, :except => [:new, :create, :login, :create_session, :forgot_password, :reset_password, :update_password]
  before_filter :nonprofit_owner, :only => [:edit, :logout, :account, :transactions, :change_password]

  layout 'nonprofit'
  include NonprofitsHelper
  
  def index
    @head[:title] = "Browse non-profit partners and support them"
    @nonprofits = is_admin? ? Nonprofit.all : Nonprofit.verified
    @categories = @nonprofits.collect(&:categories).flatten.uniq
    # FIXME: To add index-tank search on the following Nonprofit criteria:
    # name, EIN, category, mission, guideline, description, website
    render :locals => { :search => true }
  end

  def show
    @head[:title] = @nonprofit.name + " profile"
  end
  
  def new
    return redirect_to nonprofit_path(current_nonprofit) if nonprofit_logged_in?
    @head[:title] = "Non-profit partner application"
    @nonprofit = Nonprofit.new

    # We are explicitly rendering a layout in the view ;)
    render :layout => false
  end

  def edit
    @nonprofit = Nonprofit.find(params[:id])
    @head[:title] = @nonprofit.name + " - Edit profile information"
    # reset stagnant URL if any
    session[:referer] = 'edit'
    @nonprofit.build_location unless @nonprofit.location
  end
  
  def create
    logger.info(params[:nonprofit])
    @nonprofit = Nonprofit.new(params[:nonprofit])
    if @nonprofit.save
      #flash[:notice] = "Thank you for submitting your application to become a GoodInKind non-profit partner. We will be in touch with you shortly"
      #redirect_to  root_path
      #Temporarily after Non-profit creation it has been redirected to www.goodinkind.com 
      @class_name = "main_login"
      render :action => :thankyou, :layout => 'signup'
    else
      # We are explicitly rendering a layout in the view ;)
      render :action => :new, :layout => false
    end
  end

  # Update gets called from /account and /edit page
  def update
    referer = session[:referer]

    category_id = params[:nonprofit][:category_ids]
    params[:nonprofit].delete(:category_ids)
    if @nonprofit.update_attributes(params[:nonprofit])
      nonprofit_category = @nonprofit.nonprofit_categories
      if nonprofit_category.blank?
        NonprofitCategory.create(:nonprofit_id => @nonprofit.id, :category_id => category_id)
      else
        nonprofit_category = nonprofit_category.first
        nonprofit_category.category_id = category_id
        nonprofit_category.save
      end
      if referer == 'account'
        flash[:notice] = "Account information for #{@nonprofit.name} has been updated"
      else
        flash[:notice] = "Profile information for #{@nonprofit.name} has been updated"
      end
      session[:referer] = nil # cleanup first!
      if is_admin? 
        redirect_to  nonprofits_path 
      else
        redirect_to  (referer == 'account' ? account_nonprofit_path(@nonprofit) : nonprofit_path(@nonprofit) )
      end
    else
      render :action => referer
    end
  end

  def change_password
    # If old_password and password are not blank validate the old
    # password and if its correct, change it to the new one!
    if Nonprofit.authenticate(@nonprofit.username, params[:old_password]) 
      unless (params[:nonprofit][:password] != params[:nonprofit][:password_confirmation] || params[:nonprofit][:password].blank?) 
        # invoke private method!
        @nonprofit.send(:update_password, params[:nonprofit][:password]) 

        # remove these parameters from the params
        params.delete(:old_password)
        params[:nonprofit].delete(:password)
        params[:nonprofit].delete(:password_confirmation)
        flash[:notice] = "Password has been successfully changed"
        redirect_to :action => 'account'
      else
        @nonprofit.errors.add(:base, "Invalid or mismatch password")
        render :action => :account
      end
    else
      @nonprofit.errors.add(:base, "Invalid or mismatch password")
      render :action => 'account'
    end
  end

  def account
    # Maintain a session variable, to identify the referrer in update action
    @head[:title] = @nonprofit.name + " account information"
    session[:referer] = 'account'
  end

  def transactions
    # FIXME
    @head[:title] = @nonprofit.name + " transactions"
    @transactions = []
    #@transactions = @nonprofit.services.collect(&:transactions)
  end

  def login
    return redirect_to nonprofit_path(current_nonprofit) if nonprofit_logged_in?
    @nonprofit = Nonprofit.new
    @head[:title] = "non-profit partners login"
    @class_name = "main_login"
    render :layout => 'signup'
  end

  def create_session 
    @nonprofit = Nonprofit.authenticate(params[:nonprofit][:username],params[:nonprofit][:password])
    if @nonprofit && @nonprofit.is_verified == NONPROFIT_STATE[1] 
      session[:nonprofit] = {}
      session[:nonprofit][:name] = @nonprofit.name
      session[:nonprofit][:id] = @nonprofit.id
      redirect_to nonprofit_path(@nonprofit)
    else
      @nonprofit = Nonprofit.new
      @nonprofit.errors.add(:base, "Invalid Username / Password" )
      @class_name = "main_login"
      render :action => 'login', :layout => 'signup'
    end
  end

  def logout
    session[:nonprofit] = nil
    redirect_to root_path
  end

  def search
    @nonprofits = []
    unless params[:text].blank?
      result = INDEX.search(params[:text]) 
      unless result['matches'] == 0
        ids = result['results'].collect do |result|
          arr = result['docid'].split(':')
          arr.last if arr.first == 'Nonprofit'
        end
        
        @nonprofits = Nonprofit.verified.where(['id in (?)', ids.compact]).includes(:categories)
        @categories = @nonprofits.collect(&:categories).flatten.uniq
      end
    end
    render :action => 'index',:locals => { :search => true }
  end


  def forgot_password
    @nonprofit = Nonprofit.new
    if request.post?
      nonprofit = Nonprofit.find_by_username(params[:nonprofit][:username])
      if nonprofit
        nonprofit.reset_password_token = ActiveSupport::SecureRandom.hex(10)
        nonprofit.save(:validate => false)
        Notifier.reset_password_instructions(nonprofit).deliver
        flash[:notice] = "Instructions to change your password have been sent to the email address on your profile"
        redirect_to '/'
      else
        @nonprofit.errors.add(:base, "Invalid Username" )
        @class_name = "main_login"
        render :action => 'forgot_password', :layout => "signup"
      end
    else
      @class_name = "main_login"
      render :action => 'forgot_password', :layout => "signup"
    end
  end

  def reset_password
    get_nonprofit_reset_token
    #@nonprofit.clean_up_passwords
    unless @nonprofit
      flash[:notice] = "The link has already been used!!!. Please click on forgot password link to reset your password again."
      redirect_to :action => 'login'
    else
      @class_name = "main_login"
      render :action => 'reset_password', :layout => "signup"
    end
  end

  def update_password
    get_nonprofit_reset_token
    if (params[:nonprofit][:password] == params[:nonprofit][:password_confirmation]) and !params[:nonprofit][:password].blank?
      @nonprofit.send(:update_password, params[:nonprofit][:password])   
      @nonprofit.reset_password_token = nil
      @nonprofit.save(:validate => false)
      flash[:notice] = "Your password was changed successfully."
      redirect_to :action => 'login'
    else
      flash[:notice] = "Password did not match"
      @class_name = "main_login"
      render :action => 'reset_password', :layout => "signup"
    end
  end

  def forgot_username
    @nonprofit = Nonprofit.new
    if request.post?
      nonprofit = Nonprofit.find_by_EIN(params[:nonprofit][:EIN])
      if nonprofit
        Notifier.send_username(nonprofit).deliver
        flash[:notice] = "Email was sent successfully"
        redirect_to '/'
      else
        @nonprofit.errors.add(:base, "Invalid EIN" )
        @class_name = "main_login"
        render :action => 'forgot_username', :layout => "signup"
      end
    else
      @class_name = "main_login"
      render :action => 'forgot_username', :layout => "signup"
    end
  end

  def search_nonprofit
    response = FirstGiving.search(params[:ein].gsub('-',''))
    @response  = {}
    unless response['payload']['payload'].blank?
      @response = response['payload']['payload']['key_0']
      @category_id = NONPROFIT_CATEGORY[@response['category_code'][0].to_s]
    else
      render :status => 204
    end
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
    return true if is_nonprofit_owner? || is_admin?
    redirect_to login_nonprofits_path
  end

  def get_nonprofit_reset_token
    @nonprofit = Nonprofit.find_by_reset_password_token(params[:reset_password_token] || params[:nonprofit][:reset_password_token])
  end

end
