class Notifier < ActionMailer::Base


  # Send mails to offerer, buyer and nonprofit on successful buy
  def buy_success_offerer(email,title)
    @service_title = title
    subject = "One user has purchased your service"
    setup_email(email, subject)
  end

  def buy_success_buyer(email,title)
    @service_title = title
    subject = "Thank you for purchasing a service"
    setup_email(email, subject)
  end

  def buy_success_nonprofit(email,title)
    @service_title = title
    subject = "One user has purchased service to support your cause"
    setup_email(email, subject)
  end

  def buy_failed_buyer(email,title)
    @service_title = title
    subject = "Trasaction failed for purchasing a service"
    setup_email(email, subject)
  end

  def new_request(email,title)
    @request_title = title
    subject = "Thank you for submitting a service request"
    setup_email(email, subject)
  end

  def new_service_request(id,title,email)
    @service_id = id
    @request_title = title
    subject = "New service offered as per your request"
    setup_email(email, subject)
  end

  def new_message(email)
    subject = "New message received"
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
    setup_email(nonprofit.email,subject)
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
  def service_invitation(email,message,offerer_email)
    @message = message
    subject = "GoodinKind Service Invitation"
    setup_email(email, subject, offerer_email)
  end

  private

  def setup_email(sent_to, subject, sent_by=nil)
    sent_by = sent_by == nil ? GIK_EMAIL : sent_by
    mail(:from => sent_by,
         :to => sent_to,
         :subject => subject)
  end

end
