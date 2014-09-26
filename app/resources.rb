require 'sinatra'
require 'opal'
require "opal-jquery"

get '/' do
  File.read( 'pages/layout.html' )
end

get '/pages/:page' do
  File.read( "pages/#{ params[ :page ]}.html" )
end

get '/compiled_js/:page' do
  content_type "text/javascript"
  file = params[ :page ].gsub( /\.js$/, '.rb' )
  Opal.compile( File.read( "ruby_js/#{ file }" ))
end


# get '/js/opal.js' do
#   content_type "text/javascript"
#   Opal::Builder.build('opal')
# end

# get '/js/opal-jquery.js' do
#   content_type "text/javascript"
#   Opal::Builder.build('opal-jquery')
# end