class FirstGiving
  include HTTParty
  base_uri FIRST_GIVING[:url]
  format :xml
  headers 'JG_SECURITYKEY' => FIRST_GIVING[:key], 'JG_SECURITYTOKEN' => FIRST_GIVING[:token]

  def self.post(*args)
    handle_response(super)
  end

  def self.handle_response(response)
    case response.code
    when 400...500
      raise FirstGivingError.new(response.code.to_s + response.body)
    else 
      response
    end
  end

  def self.cardonfile(credit_card, payment)
    res = "<?xml version='1.0' encoding='UTF-8'?>
    <firstGivingDonationApi>
    <firstGivingResponse acknowledgement='Success'>
    <cardOnFileId>3c5e29a0-b96e-11e0-a4dd-0800200c9a66</cardOnFileId>
    </firstGivingResponse>
    </firstGivingDonationApi>"

    res = self.post('/cardonfile', :damn => "this works")

    doc = Nokogiri::XML(res);
    id = doc.xpath('/firstGivingDonationApi/firstGivingResponse[@acknowledgement="Success"]/cardOnFileId').text rescue ""
    code = doc.xpath('/firstGivingDonationApi/firstGivingResponse').first.attributes['acknowledgement'].value rescue "Unknown"

    # Return a hash of for code and id.
    [code, id ]
  end
end
