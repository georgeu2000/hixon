def bind
  Element.find( '#create_in_browser' ).on( :click ) do
    html = "new item: <input type='text' name='name'><br />"
    Element.find( '#create_items' ).append html
  end

  Element.find( 'div#new_item #submit' ).on( :click ) do
    name = Element.find( 'div#new_item input' ).value
    
    create_item_for( model:'item', name:name )
  end
end

def create_item_for params
  cid = generate_cid
  update_element_cid 'div#new_item', cid
  
  send_data( action:'create', model:params[ :model ], name:params[ :name ], cid:cid )
end

def update_element_cid finder, cid
  Element.find( finder ).attr( 'data-cid', cid )
end

Document.ready? do
  bind
end