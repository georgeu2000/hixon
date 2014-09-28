def read_items
  puts "#{ __method__ } starting..."
  send_data( action:'read', model:'item' )
end


def bind
  Element.find( 'div#items button.delete' ).on( :click ) do |e|
    model = Element.find( e.target ).data( 'model' )
    cid   = Element.find( e.target ).data( 'cid'   )
    
    send_data( action:'delete', model:model, cid:cid )
  end
end

class Socket
  def on_message json_data
    puts "Received message: #{ json_data }"
    
    parsed = JSON.parse( json_data ,symbolize_keys:true )
    model  = parsed[ :model ] 
    attributes = parsed[ :attributes ]
    
    return unless parsed
    
    Element.find( "#items" ).append delete_html_for( model, attributes )
    bind
  end

  def delete_html_for model, attributes
    "<div class='item'>
       Name: #{ attributes[ :name ]}
       <button class='delete' data-model='#{model }' data-cid='#{ attributes[ :cid ]}'>delete</button>
     </div>"
  end
end


Document.ready? do
  read_items
  bind
end
