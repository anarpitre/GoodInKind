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

  def service_suggest(count)
      if ActiveRecord::Base.connection.adapter_name == "PostgreSQL" 
         suggestion = Suggestion.order("RANDOM()")
      else
         suggestion = Suggestion.order("RAND()")
      end
      suggestion.limit(count)
  end

  def get_full_name(user=nil)
    user = user == nil ? current_user : user
    return "#{user.profile.first_name} #{user.profile.last_name}"

  end

end
