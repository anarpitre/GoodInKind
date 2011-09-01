class Notifier < ActionMailer::Base


  def service_offer(email, city)
    @invite_email = email
    @invite_city = city
    mail(:from => email,
         :to => "admin@goodinkind.com",
         :subject => "A User form #{city}  wants to offer and purchase virtual services regardless of his location")
  end

  def nonprofit_application(email, contactname, name)
    @nonprofit_name = contactname
    mail(:from => "GoodInKind <emailalerts@goodinkind.com>",
         :to => email,
         :subject => "Your GoodInKind partner application for #{name}")
  end
  def reset_password_instructions(nonprofit)
    @nonprofit = nonprofit
    mail(:from => "GoodInKind <emailalerts@goodinkind.com>",
         :to => nonprofit.email,
         :subject => "Your GoodInKind password change instruction")
  end
  
  def send_username(nonprofit)
    @nonprofit = nonprofit
    mail(:from => "GoodInKind <emailalerts@goodinkind.com>",
         :to => nonprofit.email,
         :subject => "Your GoodInKind username")
  end


  def nonprofit_approved(email, contactname, permalink)
    @nonprofit_name = contactname
    @nonprofit_perm = permalink
    mail(:from => "GoodInKind <emailalerts@goodinkind.com>",
         :to => email,
         :subject => "Your GoodInKind partner application has been approved")
  end

  def nonprofit_rejected(email)
    mail(:from => "GoodInKind <emailalerts@goodinkind.com>",
         :to => email,
         :subject => "Update on status of your GoodInKind application")
  end

end
