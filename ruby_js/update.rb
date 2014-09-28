def read_items
  puts "#{ __method__ } starting..."
  send_data( action:'read', model:'item' )
end


def bind
  Element.find( 'div#items button.update' ).on( :click ) do |e|
    input = Element.find( e.target ).parent.children( 'input' )
    name   = input.prop( 'value' )
    model  = input.data( 'model' )
    cid    = input.data( 'cid'   )
    
    send_data( action:'update', model:model, name:name, cid:cid )
  end
end

class Socket
  def on_message json_data
    puts "Received message: #{ json_data }"
    
    parsed = JSON.parse( json_data ,symbolize_keys:true )
    model  = parsed[ :model ] 
    attributes = parsed[ :attributes ]
    
    return unless parsed
    
    Element.find( "#items" ).append update_html_for( model, attributes )
    bind
  end

  def update_html_for model, attributes
     "<div id='new_item'>
        Name:<input type='text' name='name' 
              value='#{ attributes[ :name ]}' 
              data-model='#{ model }'
              data-cid='#{ attributes[ :cid ]}'>
        <button class='update'>update</button>
      </div>"
    end
end


Document.ready? do
  read_items
  bind
end
