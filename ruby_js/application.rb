require 'opal'
require 'jquery'
require 'opal-jquery'

def alert msg
  `alert(msg)`
end

# alert 'Hi there!'

def get_page page
  puts "#{ __method__ } #{ page } starting..."

  request = HTTP.get( "/pages/#{ page }" )

  request.callback {
    puts "#{ __method__ } #{ page } response received!"
    Element.find( '#page_content' ).html request.body
  }
  request.errback {
    puts "ERROR: #{ __method__ } #{ page }."
  }
end

NAV_ITEMS = [ :create, :read ]
def bind_nav
  NAV_ITEMS.each do |nav|
    Element.find( "#nav_#{ nav }" ).on( :click ) do
      get_page( nav )
    end
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
  bind_nav
end