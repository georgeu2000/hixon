require 'opal'
require 'jquery'
require 'opal-jquery'


def get_page page
  request = HTTP.get( "/pages/#{ page }" )

  request.callback {
    Element.find( '#page_content' ).html request.body
    init_views
  }
  request.errback {
    puts "ERROR: ruby_js/application.rb get_page failed for #{ page }."
  }
end


def get_template template
  t2 = template.gsub( '-', '_' )
  HTTP.get( "/templates/#{ t2 }", async: false ) do |response|
    if ! response.ok?
      puts "ERROR: ruby_js/application.rb get_template failed for #{ template }."
    end
  end.body
end


NAV_ITEMS = [ :todos, :new_post, :all_post ]
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
  element = Element.find( evt.target ).parent
  data = data_for( element )

  if data[ :cid ].nil? || data[ :cid ].blank? 
    data[ :cid ] = Cid.generate
  end

  data.merge!( action:'create', model:model, view:view )
  
  send_data data
end

def create_item_for params
  # Deprecated
  send_data params.merge( action:'create', cid:params[ :cid ])
end

def update_item_for params
  send_data params.merge( action:'update', cid:params[ :cid ])
end

#TODO depricate
def init_views_for model_view
  Logger.write "#{ __method__ } starting..."

  Element.find( 'div[ data-view ]' ).each do |view|
    method = view.attr( 'data-view' ).gsub( '-', '_' )
    model_view.send( method )
  end
end

def init_views
  Logger.write "#{ __method__ } starting..."

  Element.find( 'div[ data-view ]' ).each do |view_element|
    view_name = view_element.attr( 'data-view' )
    view = Utils.view_model_for_view_name( view_name )
    view.send( :init )
  end
end



def has_child? parent, finder
  parent.children( finder ).count > 0
end

# Replace with JSON SerializeObject
def data_for element
  data = {}
  
  element.children.each do |e|
    tag = e.prop( 'tagName' ).downcase.to_sym
    next unless [ :input, :textarea ].include? tag
    
    name = e.prop( 'name' )
    data[ name ] = value_for( e )
  end

  Logger.write "data: #{ data }"

  data
end

def value_for input
  case input.data( 'type' )
    when 'text', 'date', 'time', 'textarea'
      input.value
    when '' # select
    when 'checkbox'
      input.is( ':checked' )
    when 'radio'
  end
end

def process_message_for view_name, model_name, attributes
  raise "#{ self.class }##{ __method__ } view_name is nil" if view_name.nil?
  
  view = Utils.view_model_for_view_name( view_name )
  view.update_for_message view_name, model_name, attributes
end

def save_for evt
  element   = Element.find( evt.target ).parent
  model = element.data( 'model' )

  #TODO - Why do we need || parent?
  view  = element.data( 'view' ) || element.parent.data( 'view' )
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

def current_location
  Native(`window`)[:location][:href]
end

Document.ready? do
  bind_nav
end

class Socket
  def on_message json_data
    Logger.write "Browser received data: #{ json_data }"
    
    parsed = JSON.parse( json_data ,symbolize_keys:true )
    model  = parsed[ :model ]
    view   = parsed[ :view  ]
    attributes = parsed[ :attributes ]
    return unless attributes

    process_message_for view, model, attributes
  end
end


ENTER_KEY = 13
