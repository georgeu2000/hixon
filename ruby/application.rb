require 'opal'
require 'jquery'
require 'opal-jquery'

def alert msg
  `alert(msg)`
end

# alert 'Hi there!'

def bind
  Element.find( '#create_in_browser' ).on( :click ) do
    html = "<input type='text' name='name'><br />"
    Element.find( '#items' ).append html
  end
end

Document.ready? do
  bind
end