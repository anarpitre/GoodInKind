class AuthenticationsController < ApplicationController
  
  def index
    @authentications = current_user.authentications if current_user
  end
  
  def create
    omniauth = request.env["omniauth.auth"]
    omniauth['uid'] = omniauth['user_info']['email'] if omniauth['provider'] == 'google'
    authentication = Authentication.find_by_provider_and_uid(omniauth['provider'], omniauth['uid'])
    session[:thank_you] = "yes" unless session[:service_id].blank?
    if authentication
      change_service_offerer(session[:service_id],authentication.user.id) unless session[:service_id].blank? 
      flash[:notice] = "Signed in successfully."
      sign_in_and_redirect(:user, authentication.user)
    elsif current_user
      current_user.authentications.create!(:provider => omniauth['provider'], :uid => omniauth['uid'])
      flash[:notice] = "Authentication successful."
      redirect_to authentications_url
    else
      user = User.new
      user.build_profile
      user.apply_omniauth(omniauth)
      if user.save
        change_service_offerer(session[:service_id],user.id) unless session[:service_id].blank? 
        flash[:notice] = "Registered successfully."
        sign_in_and_redirect(:user, user)
      else
        session[:omniauth] = omniauth.except('extra')
        redirect_to new_user_registration_url
      end
    end
  end
  
  def destroy
    @authentication = current_user.authentications.find(params[:id])
    @authentication.destroy
    flash[:notice] = "Successfully destroyed authentication."
    redirect_to authentications_url
  end

end
