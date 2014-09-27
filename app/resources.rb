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