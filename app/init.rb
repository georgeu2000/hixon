
require 'awesome_print'
require 'mongoid'
Mongoid.load!( 'config/mongoid.yml', :test )

# Crimson
require './models/utils.rb'
require './models/cid.rb'
require './models/message_to_browser.rb'

# Models
require './models/crimson_model.rb'
require './models/item.rb'
require './models/big_data_item.rb'
require './models/todo.rb'

# Move
require './models/controller.rb'

# View Models
require './view_models/view_model.rb'
require './view_models/item_view.rb'
require './view_models/todo_view.rb'

# HTTP Resources
require './app/resources.rb'


set :public_folder, 'public'
