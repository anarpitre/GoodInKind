class FirstGiving
  include HTTParty
  base_uri FIRST_GIVING[:url]
  format :xml
  headers 'JG_APPLICATIONKEY' => FIRST_GIVING[:key], 'JG_SECURITYTOKEN' => FIRST_GIVING[:token]

  def self.post(*args)
    handle_response(super)
  end

  def self.handle_response(response)
    case response.code
    when 500
      raise FirstGivingError.new(response.code.to_s + response.body)
    else 
      response
    end
  end

  def self.cardonfile(credit_card, booking)
    params = prepare_params(credit_card, booking)
    res = self.post('/cardonfile', :query => params)

    code = res['firstGivingDonationApi']['firstGivingResponse']['acknowledgement'] rescue "Unknown"
    if code == 'Failed'
      id = res['firstGivingDonationApi']['firstGivingResponse']['verboseErrorMessage']
    else
      id = res['firstGivingDonationApi']['firstGivingResponse']['cardOnFileId']
    end

    # TODO: handle error

    # Return a hash of for code and id.
    [code, id ]
  end


  protected
  def self.prepare_params(credit_card, booking)
    params = {}
    params[:ccNumber] = credit_card.number
    params[:ccType] = FIRST_GIVING_TYPEMAP[credit_card.type]
    params[:ccExpDateMonth] = credit_card.month
    params[:ccExpDateYear] = credit_card.year
    params[:ccCardValidationNum] = credit_card.verification_value

    params[:accountName] = booking.accountName
    params[:billToFirstName] = booking.billToFirstName
    params[:billToLastName] = booking.billToLastName
    params[:billToLastName] = booking.billToLastName
    params[:billToAddressLine1] = booking.billToAddressLine1
    params[:billToAddressLine2] = booking.billToAddressLine2
    params[:billToCity] = booking.billToCity
    params[:billToState] = booking.billToState
    params[:billToZip] = booking.billToZip
    params[:billToCountry] = booking.billToCountry
    params[:billToEmail] = booking.billToEmail
    params[:billToPhone] = booking.billToPhone
    params[:remoteAddr] = booking.remoteAddr

    params
  end
end
