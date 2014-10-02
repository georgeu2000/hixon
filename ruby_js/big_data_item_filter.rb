
def read_big_data_items
  puts "read_big_data_items starting..."
  send_data( action:'read', model:'BigDataItem', filter:'drink:Coke' )
end

class Socket
  def on_message json_data
    puts "Browser received data: #{ json_data }"
    
    parsed = JSON.parse( json_data ,symbolize_keys:true )
    model = parsed[ :model ]
    attributes = parsed[ :attributes ]
    return unless attributes
    
    html = BigDataItemView.alternate_html_for_read( model, attributes )
    Element.find( "#big_data_items" ).append html

    set_for attributes
  end

  def set_for attributes
    div = Element.find( ".big_data_item_read:not([ data-cid])" )
    div.attr( 'data-cid', attributes[ :cid ])

    attributes.each do |k,v|
      div.find( "span[ name='#{ k }']" ).text = v
    end
  end
end

Document.ready? do
  read_big_data_items
end