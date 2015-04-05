require File.expand_path('config/site.rb') if File.exists?('config/site.rb')

# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!
