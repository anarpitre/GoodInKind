require 'rubygems'

# Set up gems listed in the Gemfile.
#ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)

#require 'bundler/setup' if File.exists?(ENV['BUNDLE_GEMFILE'])

# Set up gems listed in the Gemfile.
=begin
GEMFILE_PATH = File.expand_path('../../Gemfile', __FILE__)
if File.exist?(GEMFILE_PATH)
  # Force the rails 3 application to use its Gemfile
  ENV['BUNDLE_GEMFILE'] = GEMFILE_PATH
  require 'bundler'
  Bundler.setup
end
=end

gemfile = File.expand_path('../../Gemfile', __FILE__)
begin
  ENV['BUNDLE_GEMFILE'] = gemfile
  require 'bundler'
  Bundler.setup
rescue Bundler::GemNotFound => e
  STDERR.puts e.message
  STDERR.puts "Try running `bundle install`."
  exit!
end if File.exist?(gemfile)

