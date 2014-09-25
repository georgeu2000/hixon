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

  Element.find( 'div#new_item #submit' ).on( :click ) do
    new_name = Element.find( 'div#new_item input' ).value
    send_serialized( name:new_name )
  end
end

def send_serialized data
  $$.socket.send data.to_json
end

Document.ready? do
  bind
end