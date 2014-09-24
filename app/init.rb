puts :____INIT_____

require 'awesome_print'
require 'mongoid'
Mongoid.load!( 'config/mongoid.yml', :test )

require './models/queue_item.rb'
require './models/store.rb'
require './app/resources.rb'

set :public_folder, 'public'