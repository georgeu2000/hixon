def read_items
  Logger.write "#{ __method__ } starting..."
  send_data( action:'read', model:'Item' )
end

class Socket
  def on_message json_data
    Logger.write "Received message: #{ json_data }"
    
    parsed = JSON.parse( json_data ,symbolize_keys:true )
    model = parsed[ :model ]
    attributes = parsed[ :attributes ]
    return unless attributes
    
    html = ItemView.html_for_read model, attributes
    Element.find( "#items" ).append html
  end
end


Document.ready? do
  read_items
end
