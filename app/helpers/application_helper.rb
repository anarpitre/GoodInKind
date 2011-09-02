module ApplicationHelper
  def gik_formatted_date(date)
    date.blank? ? "" : date.strftime("%m/%d/%Y") 
  end

  def gik_formatted_time(time)
    time.blank? ? "" : time.strftime("%I:%M %p")
  end

#Check if current user is admin
  def is_admin?
    return true if current_user.try(:is_admin)
    return false
  end

#Check if current user is owner of nonprofit
  def is_nonprofit_owner?
    return true if session[:nonprofit] and (session[:nonprofit][:id] == @nonprofit.try(:id))
    return false
  end

end
