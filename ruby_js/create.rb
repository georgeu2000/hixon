def bind
  Element.find( "div.item button[ name='submit' ]" ).on( :click ) do
    name  = Element.find( "div.item input[ name='name' ]" ).value
    cid   = Element.find( "div.item" ).data( 'cid'   )
    model = Element.find( "div.item" ).data( 'model' )
    
    create_item_for( model:model, cid:cid, name:name )
  end
end

def create_item_for params
  send_data( action:'create', model:params[ :model ], name:params[ :name ], cid:params[ :cid ])
end

def render_form
  html = ItemView.render_new
  Element.find( "div#new_item" ).append html
end

Document.ready? do
  render_form
  bind
end