require 'pathname'
require 'webmock/rspec'

module WebMock
  Allow = %w(www.facebook.com, :5XxQ4mHBV7BV8w@iej.api.indextank.com/v1/indexes/idx/docs/).freeze
end

RSpec.configure do |config|
  VALID_CARD  = 370000000000002
  INVALID_CARD = 6011000000000012
  FIRST_NAME   = "test"
  LAST_NAME    = "account"
  EXPIRY_YEAR  = (Time.now.year + 10).to_s
  EXPIRY_MONTH = (Time.now.month + 1).to_s
  CVV = "123"

  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  dir = config.fixture_path + '/webmock/maps.google.com'
  stubs = {}
  Dir["#{dir}/**/*"].each  do |path|
    next  if File.directory? path
    uri = path.dup
    uri.slice!( "#{dir}/" )
    uri = File.dirname(uri)+'/'  if File.basename(uri) == '_directory'
    stubs["http://maps.google.com/#{uri}"] = path
  end


  config.around(:each) do |example|
    stubs.each { |uri, path|  WebMock::API.stub_request(:get, uri).to_return (File.new(path))  }
    stub_request(:put, /http:\/\/s3.amazonaws.com\/otz_photos\/.*/).to_return(:status => 200, :body => "", :headers => {})

    WebMock.disable_net_connect!(:allow_localhost => true, :allow => ":5XxQ4mHBV7BV8w@iej.api.indextank.com/v1/indexes/idx/docs/")
    example.call
    WebMock.allow_net_connect!
  end
end

class WebMock::NetConnectNotAllowedError
  def stubbing_instructions(sig)
    text = "\n\n"
    text << "You can stub this request with the following command:\n\n"
    if sig.method == :get
      dir = RSpec.configuration.fixture_path + '/webmock/'  + sig.uri.host
      dir += ":#{sig.uri.port}"  if sig.uri.normalized_port
      text << "  mkdir -p '#{dir}' && curl -i -o '#{dir}#{sig.uri.omit(:scheme,:userinfo,:host,:port)}' '#{sig.uri}'"
    else
      text << WebMock::StubRequestSnippet.new(sig).to_s
    end
    text << "\n\n" + "="*60
    text
  end
end

#require 'webmock/rspec'

#RSpec.configure do |config|
#  config.before(:each) do
#    stub_request(:get, /http:\/\/maps.google.com\/maps\/api\/geocode\/json?.*/).
#      with(:headers => {'Accept'=>'*/*'}).
#      to_return(:status => 200, :body => "", :headers => {})
#  end
# end
