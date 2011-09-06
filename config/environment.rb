# Load the rails application
require File.expand_path('../application', __FILE__)
require 'rubygems'
require 'indextank'

# Initialize the rails application
Gik::Application.initialize!
Date::DATE_FORMATS.merge!(:default => "%m/%d/%Y")
Time::DATE_FORMATS.merge!(
  :default => "%m/%d/%Y %:I%M%p",
  :date_time12 => "%m/%d/%Y %I:%M%p",
  :date_time24 => "%m/%d/%Y %H:%M"
)
#require "#{Rails.root}/lib/american_date_monkey_patch.rb"
