require 'opal'
require 'jquery'
require 'opal-jquery'

def alert msg
  `alert(msg)`
end

def get_page page
  request = HTTP.get( "/pages/#{ page }" )

  request.callback {
    Element.find( '#page_content' ).html request.body
  }
  request.errback {
    puts "ERROR: ruby_js/application.rb get_page #{ page }."
  }
end


def get_template template
  HTTP.get( "/templates/#{ template }", async: false ) do |response|
    if ! response.ok?
      puts "ERROR: ruby_js/application.rb get_template #{ template }."
    end
  end.body
end


NAV_ITEMS = [ :create, :read, :update, :delete, :item_view, :big_data_item_form ]
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

Document.ready? do
  bind_nav
end

class Socket
  def on_message json_data
    puts "Received message: #{ json_data }"
  end
end
