require 'sinatra'
require 'opal'
require "opal-jquery"

get '/' do
  body = File.read( 'pages/layout.html' )
  nav  = File.read( 'pages/nav.html'    )
  body.gsub( '{{& nav }}', nav )
end

get '/pages/:page' do
  File.read( "pages/#{ params[ :page ]}.html" )
end

get '/compiled_js/:page' do
  page = params[ :page ].gsub( /\.js$/, '' )
  compile( 'ruby_js', page )
end

get '/compiled_js/models/:page' do
  page = params[ :page ].gsub( /\.js$/, '' )
  compile( 'models', page )
end

get '/compiled_js/view_models/:page' do
  page = params[ :page ].gsub( /\.js$/, '' )
  compile( 'view_models', page )
end

def compile folder, file
  content_type "text/javascript"
  Opal.compile( File.read( "#{ folder }/#{ file }.rb" ))
end




# get '/js/opal.js' do
#   content_type "text/javascript"
#   Opal::Builder.build('opal')
# end

# get '/js/opal-jquery.js' do
#   content_type "text/javascript"
#   Opal::Builder.build('opal-jquery')
# end