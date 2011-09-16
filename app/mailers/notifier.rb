class Notifier < ActionMailer::Base
  
  include ApplicationHelper


  #mail to offerer when review is posted
  def review_posted(email,permalink) 
    @service_permalink = permalink 
    subject = "A review was posted for your service"
    setup_email(email, subject)
  end

  #mail to admin for failed transaction
  def failed_transaction(booking)
    @booking = booking
    subject = "Purchase transaction failed notice"
    setup_email(ADMIN_EMAIL, subject)
  end

  # Send mails to offerer, buyer and nonprofit on successful buy
  def buy_success_offerer(booking)
    @service_title = booking.service.title
    @booking_trnx_id = booking.transaction.FG_trnx_id
    @buyer_name = booking.user.profile.full_name
    @buyer_email = booking.user.email
    @nonprofit_name = booking.service.nonprofit.name
    @spots = booking.seats_booked
    @amount = booking.total_amount
    @email = booking.service.user.email
    subject = "Someone purchased your service on GoodInKind"
    setup_email(@email, subject)
  end

  def buy_success_buyer(booking)
    @service_title = booking.service.title
    @booking_trnx_id = booking.transaction.FG_trnx_id
    @offerer_name = booking.service.user.profile.full_name
    @offerer_email = booking.service.user.email
    @nonprofit_name = booking.service.nonprofit.name
    @spots = booking.seats_booked
    @amount = booking.total_amount
    @additional_amount = booking.additional_donation_amount
    @email = booking.user.email
    subject = "Confirmation of your purchase on GoodInKind"
    setup_email(@email, subject)
  end

  def buy_success_nonprofit(booking)
    @service_title = booking.service.title
    @buyer_name = booking.user.profile.full_name
    @buyer_email = show_email_to_nonprofit(booking.user.profile)
    @offerer_name = booking.service.user.profile.full_name
    @offerer_email = show_email_to_nonprofit(booking.service.user.profile)
    @amount = booking.total_amount
    @additional_amount = booking.additional_donation_amount
    @email = booking.service.nonprofit.email
    subject = "A service was purchased on GoodInKind to support your organization"
    setup_email(@email, subject)
  end

  def buy_failed_buyer(email,title)
    @service_title = title
    subject = "Purchase transaction failed notice"
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

  def new_service_admin(id,full_name,is_public)
    @service_id = id
    @service_offerer = full_name
    subject = "New service offered" + (is_public ? "" : " - unlisted")
    setup_email(ADMIN_EMAIL, subject)
  end

  def new_service_offerer(id,email)
    @service_id = id
    subject = "New service offered"
    setup_email(email, subject)
  end

  def new_service_nonprofit(id,full_name,hide_email,offerer_email,nonprofit_email,nonprofit_name)
    @service_id = id
    @service_offerer = full_name
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


  # Remove service
  def remove_service(email)
    subject = "Your Service has been Removed"
    setup_email(email, subject, GIK_EMAIL)
  end

  # Send admin email to notify about remove service
  def admin_remove_service_notification(service)
    @service = service
    subject = "Service #{service.title} has been removed!!"
    setup_email(ADMIN_EMAIL, subject, service.user.email)
  end

  def suggest_nonprofit(name, city, email)
    @name = name
    @city = city
    subject = "Nonprofit Suggestions"
    setup_email(ADMIN_EMAIL, subject, email)
  end

  private

  def setup_email(sent_to, subject, sent_by=nil)
    sent_by = sent_by == nil ? GIK_EMAIL : sent_by
    mail(:from => sent_by,
         :to => sent_to,
         :subject => subject)
  end

end
