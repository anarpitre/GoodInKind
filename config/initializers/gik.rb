if Rails.env =~ /development|test/
  S3_DEFAULTS = {}
else
  S3_DEFAULTS = { 
      :storage => :s3,
      :s3_credentials => "#{Rails.root}/config/s3.yml",
      :path => ":attachment/:id/:style.:extension",
      :bucket => "GIK_photos_#{Rails.env}",                       
      :default_url => "/images/missing/logo/:style.gif"
  }
end

EMAIL_REGEX = /^[a-z]+([+\.\w]+)*\w@[a-z0-9]+(\.\w+)+$/i

API_URL = 'http://:5XxQ4mHBV7BV8w@iej.api.indextank.com'


# facebook

FB_STAGING_API_ID = "203402889721350" 
FB_STAGING_SECRET_KEY= "9aa801d7ec4418a9bd81d3464a3078a0" 
FB_API_ID = "190285970988638"
FB_SECRET_KEY = "a8859f030a6c7259a61b0a7aa1774742"
