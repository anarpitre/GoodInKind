if Rails.env == 'development' || 'test'
  S3_DEFAULTS = {}
else
  S3_DEFAULTS = { 
      :storage => :s3,
      :s3_credentials => "#{Rails.root}/config/s3.yml",
      :path => ":attachment/:id/:style.:extension",
      :bucket => 'yourbucket',                       
      :default_url => "/images/missing/logo/:style.gif"
  }
end

