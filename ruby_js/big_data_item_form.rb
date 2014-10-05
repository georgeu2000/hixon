def bind
  Element.find( "form.big_data_item button[ name='submit' ]" ).on( :click ) do |evt|
    handle_event_for evt, 'BigDataItem'
  end
end

def handle_event_for evt, model
  div = Element.find( evt.target ).parent
  data = data_for( div )

  cid = Cid.generate
  div.attr( 'data-cid', cid )

  data.merge!( model:model.to_s, cid:cid )
  
  create_item_for data
end

def disable_submit
  Element.find( "form.big_data_item" ).on :submit do |event|
    event.prevent_default
  end
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
    
    html = BigDataItemView.alternate_html_for_read( model )
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