def bind
  Element.find( "div.big_data_item button[ name='submit' ]" ).on( :click ) do |e|
    div = Element.find( e.target ).parent
    data = data_for( div )

    cid  = Cid.generate
    div.attr( 'data-cid', cid )
    
    data.merge!( model:'BigDataItem', cid:cid )
    puts data
    
    create_item_for data
  end
end

def data_for element
  data = {}
  
  BigDataItemView.fields.each do |f|
    value = element.children( "input[ name='#{ f }' ]" ).value
    data[ f ] = value
  end

  data
end

def create_item_for params
  send_data params.merge( action:'create', cid:params[ :cid ])
end

def render_form
  html = BigDataItemView.alternate_html_for_new
  Element.find( "div#new_big_data_item" ).append html
end

Document.ready? do
  render_form
  bind
end