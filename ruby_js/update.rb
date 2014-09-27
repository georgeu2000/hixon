def read_items
  puts "#{ __method__ } starting..."
  send_data( action:'read' )
end


def bind
  Element.find( 'div#items button.update' ).on( :click ) do |e|
    input = Element.find( e.target ).parent.children( 'input' )
    name  = input.prop( 'value' )
    cid   = input.data( 'cid' )
    
    send_data( action:'update', name:name, cid:cid )
  end
end

class Socket
  def on_message json_data
    puts "Received message: #{ json_data }"
    
    parsed = JSON.parse( json_data ,symbolize_keys:true )[ :item ]
    
    return unless parsed
    
    Element.find( "#items" ).append update_item_html_for( parsed )
    bind
  end

  def update_item_html_for parsed
     "<div id='new_item'>
        Name:<input type='text' name='name' 
              value='#{ parsed[ :name ]}' 
              data-cid='#{ parsed[ :cid ]}'>
        <button class='update'>update</button>
      </div>"
    end
end


Document.ready? do
  read_items
  bind
end
