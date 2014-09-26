def bind
  Element.find( '#create_in_browser' ).on( :click ) do
    html = "<input type='text' name='name'><br />"
    Element.find( '#items' ).append html
  end

  Element.find( 'div#new_item #submit' ).on( :click ) do
    new_name = Element.find( 'div#new_item input' ).value
    
    cid = generate_cid
    Element.find( 'div#new_item' ).attr( 'data-cid', cid )
    
    send_data( action:'create', name:new_name, cid:cid )
  end
end

Document.ready? do
  bind
end