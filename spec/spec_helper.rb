require 'capybara/rspec'
require 'capybara/poltergeist'

puts :_____SPEC_HELPER_____

require './app/init'

RSpec.configure do |config|
  config.filter_run focus:true
  config.run_all_when_everything_filtered = true
end


Capybara.configure do |config|
  config.run_server = false
  config.default_driver = :poltergeist
  config.app_host = 'http://localhost:9292'
end


