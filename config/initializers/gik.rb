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
