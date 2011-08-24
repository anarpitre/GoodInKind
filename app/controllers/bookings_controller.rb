class BookingsController < ApplicationController
  before_filter :authenticate_user! # TODO: Anonymous buyers?
  before_filter :get_service
  before_filter :update_profile

  layout 'service'

  # GET /services/:service_id/bookings/new
  def new
    @booking = @service.bookings.new

    @cardonfile = current_user.cc_token.credit_card if current_user.cc_token

    @cc = ActiveMerchant::Billing::CreditCard.new
    @cc.name = current_user.profile.full_name
  end

  # POST /services/:service_id/bookings/:id
  def create
    @booking = @service.bookings.new(params[:booking])
    @booking.user = current_user #TODO: fix for non-logged in users?

    # If no params[:cc], check if the user already had a token 
    # and if the user does have one, process the payment.
    if CARD_ON_FILE_SUPPORTED and params[:booking][:cardonfile] == true
      # Verify if user REALLY has card on file and use it
      if current_user.cc_token
        @booking.cc_captured
        @booking.save!
      else
        @cc = ActiveMerchant::Billing::CreditCard.new
        render(:action => :new) and return
      end
    else
      @cc = ActiveMerchant::Billing::CreditCard.new(params[:cc])
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
        else
          # TODO: populate errors
          # TODO: Does this mean that the cardonfile is wrong, so we remove it?
          render(:action => :new) and return
        end
      else
        @booking.cc_captured
        @booking.save!
        #TODO: Process payment using standard donation API
      end
    end
  end

private
  def get_service
    @service = Service.find(params[:service_id])
  end

  def update_profile
    # Check for mandatory profile fields.
  end
end
