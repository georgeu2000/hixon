def process_message_for view_name, model_name, attributes
  view_element = Element.find( "[ data-view='#{ view_name.gsub( '_', '-' )}' ]" )
  finder = ".#{ model_name.downcase }[ data-cid='#{ attributes[ :cid ]}' ]"

  if attributes[ :removed ]
    element = Element.find( finder )
    element.remove if element

    return
  end

  if has_child?( view_element, finder )
    this_element = Element.find( ".#{ model.downcase }[ data-cid='#{ attributes[ :cid ]}' ]" )
    view_model = Utils.view_model_for( model_name )

    view_model.update_element_for_read element, attributes
    return
  end

  create_element_for view_element, model_name, attributes
end

def create_element_for view_element, model_name, attributes
  view_model  = Utils.view_model_for( model_name )
  new_element = view_model.new_element_for( 'all-posts', attributes )
  view_element.append new_element
  bind_click_for new_element
end

def bind_click_for element
  element.on( :click ) do |evt|
    model = element.data( 'model' )
    view  = 'single'
    cid = element.attr( 'data-cid' )

    LocalStorage[ :single_post_cid ] = cid

    get_page 'single_post'
  end
end


Document.ready? do
  init_views_for PostView
end