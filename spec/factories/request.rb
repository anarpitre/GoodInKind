Factory.define :request do |req|
  req.title "ser_req"
  req.description "This is a test description"
  req.email "ser@ser.com"
  req.after_create {|bp| Factory.create(:request_location, :resource_id => bp.id, :resource_type => "Request") }
end
