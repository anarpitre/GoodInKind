if RAILS_ENV == 'production'
  S3_DEFAULTS = { 
      :storage => :s3,
      :s3_credentials => "#{RAILS_ROOT}/config/s3.yml",
      :path => ":attachment/:id/:style.:extension",
      :bucket => 'yourbucket',                       
      :default_url => "/images/missing/logo/:style.gif"
  }
else
  S3_DEFAULTS = { }
end

