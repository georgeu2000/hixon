def read_items
  puts "#{ __method__ } starting..."
  send_data( action:'read' )
end


def bind
  Element.find( 'div#items button.delete' ).on( :click ) do |e|
    cid = Element.find( e.target ).data( 'cid' )
    send_data( action:'delete', cid:cid )
  end
end

class Socket
  def on_message json_data
    puts "Received message: #{ json_data }"
    
    parsed = JSON.parse( json_data ,symbolize_keys:true )[ :item ]
    
    return unless parsed
    
    Element.find( "#items" ).append delete_item_html_for( parsed )
    bind
  end

  def delete_item_html_for parsed
    "<div class='item'>
       Name: #{ parsed[ :name ]}
       <button class='delete' data-cid='#{ parsed[ :cid ]}'>delete</button>
     </div>"
  end
end


Document.ready? do
  read_items
  bind
end
