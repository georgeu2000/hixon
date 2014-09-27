def read_items
  puts "#{ __method__ } starting..."
  send_data( action:'read' )
end

class Socket
  def on_message json_data
    puts "Received message: #{ json_data }"
    
    parsed = JSON.parse( json_data ,symbolize_keys:true )[ :attributes ]
    
    return unless parsed
    
    html = "<div class='item'>" + parsed[ 'name' ] + "</item>"
    Element.find( "#items" ).append html
  end
end


Document.ready? do
  read_items
end
