def read_items
  puts "#{ __method__ } starting..."
  send_data( action:'read', model:'item' )
end


def bind
  Element.find( "div#items .item button[ name='submit' ]" ).on( :click ) do |e|
    parent = Element.find( e.target ).parent
    input  = parent.children( :input )
    name   = input.prop( :value )
    model  = parent.data( :model )
    cid    = parent.data( :cid   )
    
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
    
    Element.find( "#items" ).append ItemView.html_for( model, attributes )
    bind
  end
end


Document.ready? do
  read_items
  bind
end
