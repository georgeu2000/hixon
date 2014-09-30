
require 'awesome_print'
require 'mongoid'
Mongoid.load!( 'config/mongoid.yml', :test )

require './models/utils.rb'
require './models/cid.rb'
require './models/message_to_browser.rb'
require './models/crimson_model.rb'
require './models/item.rb'
require './models/big_data_item.rb'
require './models/controller.rb'
require './view_models/view_model.rb'
require './view_models/item_view.rb'
require './app/resources.rb'


set :public_folder, 'public'
