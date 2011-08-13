module NonprofitHelper
  def nonprofit_logged_in?
    np = (session[:nonprofit] and session[:nonprofit][:id]) ? true : false
  end

  def format_link(nonprofit)
    return "http://#{nonprofit}" unless nonprofit =~ /^http:\/\//
    return nonprofit
  end
end
