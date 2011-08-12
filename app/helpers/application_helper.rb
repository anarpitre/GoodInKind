module ApplicationHelper
  def gik_formatted_date(date)
    date.blank? ? "" : date.strftime("%m/%d/%Y") 
  end

  def gik_formatted_time(time)
    time.blank? ? "" : time.strftime("%I:%M %p")
  end
end
