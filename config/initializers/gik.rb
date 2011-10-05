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

CELL_NO_REGEX = /^(1\-?)?\s?\(?\d{3}\)?(\-|\s)?\d{3}(\-|\s)?\d{4}$/i
EIN_REGEX = /^\d{2}-\d{7}$/i
WEBSITE_REGEX= /^((http|https):\/\/)?[a-z0-9]+(\.[a-z0-9]+)?.[a-z]{2,5}$/i

if Rails.env == 'production'
  ADMIN_EMAIL = "admin@goodinkind.com"
else
  ADMIN_EMAIL = "molecularsequence@yahoo.com"
end
GIK_EMAIL = "GoodInKind <alerts@goodinkind.com>"

NONPROFIT_STATE = ['Pending','Verified','Rejected'] 

# facebook

FB_STAGING_API_ID = "203402889721350" 
FB_STAGING_SECRET_KEY= "9aa801d7ec4418a9bd81d3464a3078a0" 
FB_API_ID = "190285970988638"
FB_SECRET_KEY = "a8859f030a6c7259a61b0a7aa1774742"
FB_PRODUCTION_API_ID = "146470382109652"
FB_PRODUCTION_SECRET_KEY = "2b4203b9025848b05258a2a5a9358191"


# Pagination Per Page count

PER_PAGE_RECORDS = 10
