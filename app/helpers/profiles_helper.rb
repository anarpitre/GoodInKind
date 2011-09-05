module ProfilesHelper

  def get_user_name
    "#{@profile.first_name} #{@profile.last_name}"
  end

  def get_user_email
    @profile.hide_email ? "---" : @profile.user.email
  end

  def get_gender
    @profile.hide_gender ? "---" : @profile.gender
  end

  def is_owner(user)
    if current_user
      return true if user == current_user
    end
    return false
  end

  def review_context(review)
    if review.is_positive
    else
      '%span{:class => :negative }Negative'
    end
  end

  def is_expired?(service)
    service.is_schedulelater? ? false : service.end_date < Date.today
  end

  def format_link(socialnetwork)
    return "http://#{socialnetwork}" unless socialnetwork =~ /^http:\/\//
    return socialnetwork
  end
end
