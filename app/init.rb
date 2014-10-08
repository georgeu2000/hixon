
require 'awesome_print'
require 'mongoid'
Mongoid.load!( 'config/mongoid.yml', :test )

# Crimson
require './models/utils.rb'
require './models/cid.rb'
require './models/message_to_browser.rb'
require './models/controller.rb'
require './models/crimson_model.rb'
require './view_models/view_model.rb'

# App Models
require './models/item.rb'
require './models/big_data_item.rb'
require './models/todo.rb'
require './models/post.rb'

# APP Views
require './view_models/item_view.rb'
require './view_models/todo_view.rb'

# Sinatra
require './middleware/exception_handler.rb'
require './app/resources.rb'


set :public_folder, 'public'
set :dump_errors, false
 
use ExceptionHandler