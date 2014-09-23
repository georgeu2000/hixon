puts :____INIT_____

require 'mongoid'
Mongoid.load!( 'config/mongoid.yml', :test )
Mongoid::Config.purge!

require './models/store.rb'
require './app/resources.rb'

set :public_folder, 'public'