require 'opal'

# opal = Opal::Server.new {|s|
#   s.append_path 'ruby'
#   s.main = 'application'
# }

# map '/__opal_source_maps__' do
#   run opal.source_maps
# end

# map '/assets' do
#   run opal.sprockets
# end

require './app/init.rb'
require './config/disable_logger.rb'

run Sinatra::Application
