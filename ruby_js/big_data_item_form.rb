def bind
  Element.find( "form.big_data_item button[ name='submit' ]" ).on( :click ) do |e|
    div = Element.find( e.target ).parent
    data = data_for( div )

    cid = Cid.generate
    div.attr( 'data-cid', cid )
    
    data.merge!( model:'BigDataItem', cid:cid )
    
    create_item_for data
  end
end

def disable_submit
  Element.find( "form.big_data_item" ).on :submit do |event|
      event.prevent_default
    end
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
      input.value if input.is( ':checked' )
    when 'radio'
  end
end

def create_item_for params
  send_data params.merge( action:'create', cid:params[ :cid ])
end

def render_new_form
  html = BigDataItemView.html_for_new
  Element.find( "div#new_big_data_item" ).append html
end

def read_big_data_items
  puts "read_big_data_items starting..."
  send_data( action:'read', model:'BigDataItem' )
end

class Socket
  def on_message json_data
    puts "Browser received data: #{ json_data }"
    
    parsed = JSON.parse( json_data ,symbolize_keys:true )
    model = parsed[ :model ]
    attributes = parsed[ :attributes ]
    return unless attributes
    
    html = BigDataItemView.alternate_html_for_read model
    Element.find( "#read_big_data_item" ).html html

    set_for attributes
  end

  def set_for attributes
    Element.find( ".big_data_item_read" ).attr( 'data-cid', attributes[ :cid ])

    attributes.each do |k,v|
      Element.find( ".big_data_item_read span[ name='#{ k }']" ).text = v
    end
  end
end

Document.ready? do
  render_new_form
  disable_submit
  bind
  read_big_data_items
end