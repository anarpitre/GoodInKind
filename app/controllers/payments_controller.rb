class PaymentsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :get_service
  before_filter :update_profile

  layout 'service'

  def checkout
    # Here we create a payment in 'created' state. This tells us
    # - how many people wanted to take the service but didn't!!
    @payment = @service.payments.create!(:user => current_user)

    @cardonfile = current_user.payment_token.credit_card if current_user.payment_token

    @cc = ActiveMerchant::Billing::CreditCard.new
    @cc.name = current_user.profile.full_name
  end

  def pay
    @payment = Payment.find(params[:payment_id])

    # If no params[:cc], check if the user already had a token 
    # and if the user does have one, process the payment.
    if CARD_ON_FILE_SUPPORTED and params[:payment][:cardonfile] == true
      # If user has card on file, use it
      if current_user.payment_token
        @payment.status = "processing"
        #TODO: Set DelayedJob for this proessing.
        @payment.save!
      else
        @cc = ActiveMerchant::Billing::CreditCard.new
        render(:action => :checkout) and return
      end
    else
      @cc = ActiveMerchant::Billing::CreditCard.new(params[:cc])
      render(:action => :checkout) and return unless @cc.valid?

      if CARD_ON_FILE_SUPPORTED
        code, id = FirstGiving.cardonfile(@cc, @payment)

        # Save Credit Card details
        if code == 'Success'
          current_user.build_payment_token(:cardonfile_id => id, :credit_card => @cc.display_number)
          current_user.payment_token.save! #TODO: Exception handling
          @payment.status ="processing"
          #TODO: Set DelayedJob for this proessing.
          @payment.save!
        else
          # TODO: populate errors
          # TODO: Does this mean that the cardonfile is wrong, so we remove it?
          render(:action => :checkout) and return
        end
      else
        #TODO: Process payment using donation API
      end
    end
  end

private
  def get_service
    @service = Service.find(params[:id])
  end

  def update_profile
    # Check for mandatory profile fields.
  end
end
