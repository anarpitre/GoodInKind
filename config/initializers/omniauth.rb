require 'omniauth/openid'
require 'openid/store/filesystem'
Rails.application.config.middleware.use OmniAuth::Builder do
  
  # User can Sign up only through facebook 
  provider :facebook, FACEBOOK[:api_key], FACEBOOK[:secret_key], {:client_options => {:ssl => {:ca_path => "/etc/ssl/certs"}}}
  
  #provider :twitter, 'TWITTER[:api_key]', 'TWITTER[:secret_key]'
  #provider :linked_in, 'LINKED_IN[:api_key]', 'LINKED_IN[:secret_key]'
  
  # generic openid
  #provider :openid, OpenID::Store::Filesystem.new('./tmp'), :name => 'openid'

  # dedicated openid
  #provider :openid, OpenID::Store::Filesystem.new('./tmp'), :name => 'google', :identifier => 'https://www.google.com/accounts/o8/id'

  #provider :google_apps, OpenID::Store::Filesystem.new('./tmp'), :name => 'google_apps'
  # /auth/google_apps; you can bypass the prompt for the domain with /auth/google_apps?domain=somedomain.com

  #provider :openid, OpenID::Store::Filesystem.new('./tmp'), :name => 'yahoo', :identifier => 'yahoo.com' 
  #provider :openid, OpenID::Store::Filesystem.new('./tmp'), :name => 'aol', :identifier => 'openid.aol.com'
  #provider :openid, OpenID::Store::Filesystem.new('./tmp'), :name => 'myopenid', :identifier => 'myopenid.com'
end


