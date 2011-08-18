module ProfilesHelper

  def get_user_name
    "#{@profile.first_name} #{@profile.last_name}"
  end

  def get_user_email
    @profile.hide_email ? @profile.user.email : "--"
  end

  def get_gender
    @profile.hide_gender ? @profile.gender : "--"
  end

end
