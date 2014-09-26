
require 'awesome_print'
require 'mongoid'
Mongoid.load!( 'config/mongoid.yml', :test )

require './models/message_to_browser.rb'
require './models/item.rb'
require './app/resources.rb'


set :public_folder, 'public'
