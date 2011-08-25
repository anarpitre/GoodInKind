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
    when 400...510
      raise FirstGivingError.new(response.code.to_s + response.body)
    else 
      response
    end
  end

  def self.test
    res = self.post('/cardonfile', :damn => "this works")
  end
end
