require 'opal'
require 'jquery'
require 'opal-jquery'


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


NAV_ITEMS = [ :create, :read, :update, :delete, :item_view, 
              :big_data_item_form, :big_data_item_collection,
              :big_data_item_filter, :todos ]
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

def create_object_for evt, model, view
  div = Element.find( evt.target ).parent
  data = data_for( div )

  data.merge!( action:'create', model:model, cid:Cid.generate, view:view )
  
  send_data data
end

def create_item_for params
  # Deprecated
  send_data params.merge( action:'create', cid:params[ :cid ])
end

def update_item_for params
  send_data params.merge( action:'update', cid:params[ :cid ])
end

def init_views_for model_view
  puts 'init_views starting...'

  Element.find( 'div[ data-view ]' ).each do |view|
    model_view.send( view.attr( 'data-view' ))
  end
end

def disable_submit_for finder
  Element.find( finder ).on :submit do |event|
    event.prevent_default
  end
end

def has_child? parent, finder
  parent.children( finder ).count > 0
end

# Replace with JSON SerializeObject
def data_for element
  data = {}
  
  element.children.each do |e|
    next if e.prop( 'tagName' ).downcase != 'input'
    
    name = e.prop( 'name' )
    data[ name ] = value_for( e )
  end

  puts "data: #{ data }"

  data
end

def value_for input
  case input.data( 'type' )
    when 'text', 'date', 'time'
      input.value
    when '' # select
    when 'checkbox'
      input.is( ':checked' )
    when 'radio'
  end
end

def process_message_for view, model, attributes
  # Default implementation
  puts 'No message processing.'
end

def save_for evt
  element   = Element.find( evt.target ).parent
  model = element.data( 'model' )
  view  = element.data( 'view' )
  data  = data_for( element )

  cid = element.attr( 'data-cid' )

  data.merge!( action:'update', model:model, cid:cid, view:view )
  
  send_data data
end

def delete_for evt
  element = Element.find( evt.target ).parent
  model = element.data( 'model' )
  view  = element.parent.data( 'view' )
  cid   = element.data( 'cid' )

  send_data( action:'delete', model:model, view:view, cid:cid )
end

Document.ready? do
  bind_nav
end

class Socket
  def on_message json_data
    puts "Browser received data: #{ json_data }"
    
    parsed = JSON.parse( json_data ,symbolize_keys:true )
    model  = parsed[ :model ]
    view   = parsed[ :view  ]
    attributes = parsed[ :attributes ]
    return unless attributes

    process_message_for view, model, attributes
  end
end

ENTER_KEY = 13
