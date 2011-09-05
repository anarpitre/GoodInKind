class Notifier < ActionMailer::Base


  def service_city_request(email, city)
    @invite_email = email
    @invite_city = city
    subject => "Request to rollout in #{city}"
    setup_email(ADMIN_EMAIL, subject, email)
  end

  def nonprofit_application(email, contactname, name)
    @nonprofit_name = contactname
    subject => "Your GoodInKind partner application for #{name}"
    setup_email(email,subject)
  end

  def nonprofit_application_admin(name)
    @nonprofit_name = name
    subject => "Your GoodInKind partner application for #{name}"
    setup_email(email,subject)
  end

  def reset_password_instructions(nonprofit)
    @nonprofit = nonprofit
    subject => "Your GoodInKind password change instruction"
    setup_email(nonprofit.email,subject)
  end

  def send_username(nonprofit)
    @nonprofit = nonprofit
    subject => "Your GoodInKind username"
    setup_email(email,subject)
  end


  def nonprofit_approved(email, name, permalink)
    @nonprofit_name = name
    @nonprofit_perm = permalink
    subject => "Your GoodInKind partner application has been approved"
    setup_email(email,subject)
  end

  def nonprofit_rejected(email)
    subject => "Update on status of your GoodInKind application"
    setup_email(email,subject)
  end

  #Send service invitation
  def service_invitation(user,email,message)
    @message = message
    setup_email(GIK_EMAIL, subject, email)
  end

  private

  def setup_email(sent_to, subject, sent_by=nil)
    sent_by = sent_by.is_blank? ? GIK_EMAIL : sent_by
    mail(:from => sent_by,
         :to => sent_to,
         :subject => subject)
  end

end
