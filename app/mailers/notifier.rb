class Notifier < ActionMailer::Base


  def service_offer(email, city)
    @invite_email = email
    @invite_city = city
    mail(:from => email,
         :to => "admin@goodinkind.com",
         :subject => "A User form #{city}  wants to offer and purchase virtual services regardless of his location")
  end

  def nonprofit_invitation(email, name)
    @nonprofit_name = name
    @nonprofit_email = email
    mail(:from => "contact@goodinkind.com",
         :to => email,
         :subject => "Nonprofit Application")
  end
  def reset_password_instructions(nonprofit)
    @nonprofit = nonprofit
    mail(:from => "emailalerts@goodinkind.com",
         :to => nonprofit.email,
         :subject => "Your GoodInKind Reset password instructions")
  end
  
  def send_username(nonprofit)
    @nonprofit = nonprofit
    mail(:from => "emailalerts@goodinkind.com",
         :to => nonprofit.email,
         :subject => "Your GoodInKind username")
  end

end
