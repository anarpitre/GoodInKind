require 'net/http'
require 'uri'

class CharitySearch

  def self.get_non_profit_info(keyword)
    query = URI.escape("http://graphapi.firstgiving.com/graph/charity?namepartial=#{keyword}")
     uri = URI.parse(query)
    response = Net::HTTP.get_response(uri)

    hash = ActiveSupport::JSON.decode(response.body)
    results = hash['payload']['results']
    return results
  end
  
  def self.get_non_profit_uuid(keyword)
    uri = URI.parse("http://graphapi.firstgiving.com/graph/charity?charity_uuid=#{keyword}")
    response = Net::HTTP.get_response(uri)

    hash = ActiveSupport::JSON.decode(response.body)
    results = hash['payload']['results']
    return results
  end
end
