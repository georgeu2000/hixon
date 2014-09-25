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
    cid = generate_cid
  
    Element.find( 'div#new_item' ).attr( 'data-cid', cid )
    # alert( Element.find( 'div#new_item' ).attr( 'data-cid' ))
    # alert( Element.find( 'div#new_item' ).data( 'cid' ))
    
    send_data( name:new_name )
  end
end

def send_data data
  $$.socket.send data.to_json
end

CID_LENGTH = 20
def generate_cid
  rand( 36**CID_LENGTH ).to_s( 36 )
end

Document.ready? do
  bind
end