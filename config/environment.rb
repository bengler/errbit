require File.expand_path('config/site.rb') if File.exists?('config/site.rb')

# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Errbit::Application.initialize!
