require 'sinatra'

puts :_____RESOURCES_____

get '/' do
  File.read 'pages/home.html'
end