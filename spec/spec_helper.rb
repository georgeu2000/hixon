require 'capybara/rspec'
require 'capybara/poltergeist'

require './app/init'

RSpec.configure do |config|
  config.filter_run focus:true
  config.run_all_when_everything_filtered = true

  escaped_path = %r{spec/features/}
  config.define_derived_metadata( file_path: escaped_path ) do |metadata|
    metadata[ :type ] ||= :feature
  end

  config.backtrace_exclusion_patterns = [
    /\/lib\d*\/ruby\//,
    /bin\//,
    /gems/,
    /spec\/spec_helper\.rb/,
    /lib\/rspec\/(core|expectations|matchers|mocks)/
  ]

  config.before( :each ) do
    Mongoid::Config.purge!
  end
end

Capybara.configure do |config|
  config.run_server = false
  config.default_driver = :poltergeist
  config.app_host = 'http://localhost:9292'
end


