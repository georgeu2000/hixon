require 'sinatra'
require 'opal'
require "opal-jquery"

puts :_____RESOURCES_____

get '/:page' do
  html = File.read( 'pages/layout.html' )
  html.gsub( '<< page >>', File.read( "pages/#{ params[ :page ]}.html" ))
end

get '/assets/application.js' do
  content_type "text/javascript"
  Opal.compile( File.read( 'ruby/application.rb' ))
end


# get '/js/opal.js' do
#   content_type "text/javascript"
#   Opal::Builder.build('opal')
# end

# get '/js/opal-jquery.js' do
#   content_type "text/javascript"
#   Opal::Builder.build('opal-jquery')
# end