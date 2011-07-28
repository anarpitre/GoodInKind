require 'omniauth/openid'
require 'openid/store/filesystem'
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, 'qGccYRYVbwdH6tFlYah1Ng', 'vusGXcUm4GUGXq3qCOaKgjLNl0xulRB28Px0G3Bxrk'
  provider :facebook, '190285970988638', 'a8859f030a6c7259a61b0a7aa1774742', {:client_options => {:ssl => {:ca_path => "/etc/ssl/certs"}}}
  provider :linked_in, 'a33rq3rqvlcs', 'x0JSZATLpG4uPkJQ'

  # generic openid
  provider :openid, OpenID::Store::Filesystem.new('./tmp'), :name => 'openid'

  # dedicated openid
  provider :openid, OpenID::Store::Filesystem.new('./tmp'), :name => 'google', :identifier => 'https://www.google.com/accounts/o8/id'
  
  #provider :google_apps, OpenID::Store::Filesystem.new('./tmp'), :name => 'google_apps'
  # /auth/google_apps; you can bypass the prompt for the domain with /auth/google_apps?domain=somedomain.com

  #provider :openid, OpenID::Store::Filesystem.new('./tmp'), :name => 'yahoo', :identifier => 'yahoo.com' 
  #provider :openid, OpenID::Store::Filesystem.new('./tmp'), :name => 'aol', :identifier => 'openid.aol.com'
  #provider :openid, OpenID::Store::Filesystem.new('./tmp'), :name => 'myopenid', :identifier => 'myopenid.com'
end


