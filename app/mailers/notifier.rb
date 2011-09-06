class Notifier < ActionMailer::Base


  def new_message(email)
    subject = "New message reveived"
    setup_email(email, subject)
  end

  def new_service_admin(id,first_name,last_name)
    @service_id = id
    @service_offerer = "#{first_name} #{last_name}"
    subject = "New service offered"
    setup_email(ADMIN_EMAIL, subject)
  end

  def new_service_offerer(id,email)
    @service_id = id
    subject = "New service offered"
    setup_email(email, subject)
  end

  def new_service_nonprofit(id,first_name,last_name,hide_email,offerer_email,nonprofit_email,nonprofit_name)
    @service_id = id
    @service_offerer = "#{first_name} #{last_name}"
    @offerer_email = hide_email ? " " : "(#{offerer_email})"
    subject = "New service offered to benefit #{nonprofit_name}"
    setup_email(nonprofit_email, subject)
  end

  def service_city_request(email, city)
    @invite_email = email
    @invite_city = city
    subject = "Request to rollout in #{city}"
    setup_email(ADMIN_EMAIL, subject, email)
  end

  def nonprofit_application(email, contactname, name)
    @nonprofit_name = contactname
    subject = "Your GoodInKind partner application for #{name}"
    setup_email(email,subject)
  end

  def nonprofit_application_admin(name)
    @nonprofit_name = name
    subject = "Your GoodInKind partner application for #{name}"
    setup_email(ADMIN_EMAIL,subject)
  end

  def reset_password_instructions(nonprofit)
    @nonprofit = nonprofit
    subject = "Your GoodInKind password change instruction"
    setup_email(nonprofit.email,subject)
  end

  def send_username(nonprofit)
    @nonprofit = nonprofit
    subject = "Your GoodInKind username"
    setup_email(email,subject)
  end


  def nonprofit_approved(email, name, permalink)
    @nonprofit_name = name
    @nonprofit_perm = permalink
    subject = "Your GoodInKind partner application has been approved"
    setup_email(email,subject)
  end

  def nonprofit_rejected(email)
    subject = "Update on status of your GoodInKind application"
    setup_email(email,subject)
  end

  #Send service invitation
  def service_invitation(user,email,message)
    @message = message
    setup_email(GIK_EMAIL, subject, email)
  end

  private

  def setup_email(sent_to, subject, sent_by=nil)
    begin
      sent_by = sent_by == nil ? GIK_EMAIL : sent_by
      mail(:from => sent_by,
           :to => sent_to,
           :subject => subject)
    rescue  Exception => e
     puts "*********************"
      puts e
    end
  end

end
