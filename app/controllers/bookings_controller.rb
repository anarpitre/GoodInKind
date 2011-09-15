class BookingsController < ApplicationController
  before_filter :authenticate_user! # TODO: Anonymous buyers?
  before_filter :get_service
  before_filter :update_profile
  before_filter :force_ssl

  layout 'service'

  # GET /services/:service_id/bookings/new
  def new
    unless @service.is_valid_service
      flash[:notice] = 'Service does not exist'
      redirect_to '/'
    end

    @booking = @service.bookings.new

    # set some defaults
    @booking.seats_booked = 1
    @booking.additional_donation_amount = 0
    @booking.donation_amount = @booking.service.amount # default 1 seat
    @booking.GIK_charges = 0
    @booking.CC_charges = 0 
    @booking.total_amount = @booking.service.amount # default 1 seat

    # If the user has some previous bookings, we can re-use the billing info
    prev = current_user.bookings.last
    if prev
      @booking.accountName = prev.accountName
      @booking.billToCity = prev.billToCity
      @booking.billToState = prev.billToState
      @booking.billToZip = prev.billToZip
      @booking.billToCountry = prev.billToCountry
      @booking.billToAddressLine1 = prev.billToAddressLine1
      @booking.billToAddressLine2 = prev.billToAddressLine2
      @booking.billToAddressLine3 = prev.billToAddressLine3
    end

    @cardonfile = current_user.cc_token.credit_card if current_user.cc_token

    @cc = ActiveMerchant::Billing::CreditCard.new
    @cc.name = current_user.profile.full_name
  end

  # POST /services/:service_id/bookings/:id
  def create
    @cardonfile = current_user.cc_token.credit_card if current_user.cc_token

    # remove the transient param :cardonfile
    # Keep a copy, so that :new action will not get impacted
    booking_params = params[:booking].dup
    cardonfile = booking_params.delete(:cardonfile)

    @booking = @service.bookings.new(booking_params)
    @booking.user = current_user #TODO: fix for non-logged in users?
    @booking.billToEmail = current_user.email #TODO
    @booking.billToFirstName = @booking.accountName.split.first
    @booking.billToLastName = @booking.accountName.split.last
    @booking.remoteAddr = request.remote_ip 

    # Transaction fee processing
    @booking.seats_booked = @booking.seats_booked.to_i
    @booking.additional_donation_amount = (@booking.additional_donation_amount.to_f).round(2)
    @booking.donation_amount = @booking.service.amount  * @booking.seats_booked 
    @booking.total_amount = @booking.donation_amount.to_f + 
                            @booking.additional_donation_amount + 
                            @booking.GIK_charges.to_f + 
                            @booking.CC_charges.to_f

    if params[:cc]
      @cc = ActiveMerchant::Billing::CreditCard.new(params[:cc])
      @cc.valid? # populate errors if any
    end
    raise ActiveRecord::RecordInvalid.new(@booking) unless @booking.valid? 

    # If no params[:cc], check if the user already had a token 
    # and if the user does have one, process the payment.
    if CARD_ON_FILE_SUPPORTED and cardonfile == "true"
      # Verify if user REALLY has card on file and use it
      if current_user.cc_token
        @booking.cc_captured
        @booking.save!

        #TODO: A delayed job for hte actual transction!!
      else
        @cc = ActiveMerchant::Billing::CreditCard.new
        render(:action => :new) and return
      end
    else
      render(:action => :new) and return unless @cc.valid?

      if CARD_ON_FILE_SUPPORTED
        code, id = FirstGiving.cardonfile(@cc, @booking)

        # Save Credit Card details
        if code == 'Success'
          current_user.build_cc_token unless current_user.cc_token
          current_user.cc_token.cardonfile_id = id
          current_user.cc_token.credit_card = @cc.display_number
          current_user.cc_token.save! #TODO: Exception handling
          @booking.cc_captured
          @booking.save! #TODO: Exception handling

          #TODO: A delayed job for hte actual transction!!
        else
          # TODO: Does this mean that the cardonfile is wrong, so we remove it?
          # id would be verboseErrorMessage on erroe
          @booking.errors.add(:fg, "#{id}");
          render(:action => :new) and return
        end
      else
        code, id = FirstGiving.donation(@booking, @cc)

        # Update the transaction object.
        @booking.create_transaction(code, id)
        if code == 'Success'
          @booking.payment_succeeded
          @booking.save!
          Notifier.buy_success_offerer(@booking).deliver
          Notifier.buy_success_buyer(@booking).deliver
          Notifier.buy_success_nonprofit(@booking).deliver
          redirect_to service_booking_path(@service, @booking.mref), :notice => "Transaction successful!"
        else
          @booking.payment_failed
          @booking.save!
          Notifier.buy_failed_buyer(@booking.user.email,@booking.service.title).deliver
          Notifier.failed_transaction(@booking).deliver
          flash[:notice] = "Transaction unsuccessful! Please try again or contact support!"
          render(:action => :new) and return
        end
      end
    end


    rescue ActiveRecord::RecordInvalid
      @cc = ActiveMerchant::Billing::CreditCard.new(params[:cc]) unless @cc
      render(:action => :new) and return
  end

  def show
    @booking = current_user.bookings.find_by_mref(params[:id])
    unless @booking
      flash[:notice] = "No such transaction!"
      redirect_to service_path(@service) 
    end
  end

  def destroy
    booking = current_user.bookings.find_by_mref(params[:id])
    booking.destroy
  end

private
  def get_service
    @service = Service.find(params[:service_id])
  end

  def update_profile
    # Check for mandatory profile fields.
  end

  def force_ssl
    return if Rails.env != 'production'
    if !request.ssl?
      redirect_to :protocol => 'https'
    end
  end
end
