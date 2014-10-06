
def init_form
  Element.find( "div#new-todo" ).html TodoView.new_todo
  
  form = Element.find( 'form.new-todo' )

  action = lambda{ |evt| create_object_for( evt, 'Todo', 'all' )}
  bind_enter_to_input_with_action form, :text, action

  bind_enter_to_clear_input form, :text
  
  disable_submit_for 'form.new-todo'
end

def process_message_for view_name, model_name, attributes
  view_element = Element.find( "[ data-view='#{ view_name }' ]" )
  finder = ".#{ model_name.downcase }[ data-cid='#{ attributes[ :cid ]}' ]"

  if attributes[ :removed ]
    element = Element.find( finder )
    element.remove if element

    return
  end

  if has_child?( view_element, finder )
    this_element = Element.find( ".#{ model.downcase }[ data-cid='#{ attributes[ :cid ]}' ]" )
    view_model = Utils.view_model_for( model_name )

    view_model.update_element element, attributes
    return
  end

  create_element_for view_element, model_name, attributes
end

def create_element_for view_element, model_name, attributes
  view_model = Utils.view_model_for( model_name )
  new_element  = view_model.new_element_for( attributes )
  view_element.append new_element
  bind_for_new new_element 
end

def bind_for_new element
  disable_submit_for element

  bind_enter_to_input element, :text
  bind_click_to_input element, :done
  bind_click_to_link  element, :delete
end


Document.ready? do
  init_form
  init_views_for TodoView
end
