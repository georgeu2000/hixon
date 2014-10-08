
class Socket
  def on_message json_data
    Logger.write "Browser received data: #{ json_data }"
    
    parsed = JSON.parse( json_data ,symbolize_keys:true )
    model  = parsed[ :model ]
    view   = parsed[ :view  ]
    attributes = parsed[ :attributes ]
    return unless attributes
    
    html = BigDataItemView.alternate_html_for_read( model, attributes )
    Element.find( "[ data-view='#{ view }' ]" ).append html

    set_for attributes
  end

  def set_for attributes
    div = Element.find( ".big_data_item_read:not([ data-cid ])" )
    div.attr( 'data-cid', attributes[ :cid ])

    attributes.each do |k,v|
      div.find( "span[ name='#{ k }']" ).text = v
    end
  end
end

Document.ready? do
  init_views_for BigDataItemView
end