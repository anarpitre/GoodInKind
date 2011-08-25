module NonprofitsHelper
  def nonprofit_logged_in?
    current_nonprofit ? true : false
  end

  def format_link(nonprofit)
    return "http://#{nonprofit}" unless nonprofit =~ /^http:\/\//
    return nonprofit
  end

  def current_nonprofit
    return @current_nonprofit if @current_nonprofit
    id = session[:nonprofit] && session[:nonprofit][:id]
    return nil unless id
    @current_nonprofit = Nonprofit.find(id) 
  end

  def get_service_count(np)
    Service.where("nonprofit_id = ?",np.id).count
  end
end
