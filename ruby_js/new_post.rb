def init_form
  Element.find( "div#new-post" ).html PostView.new_post

  form = Element.find( 'form.new-post' )

  action = lambda{ |evt| create_object_for( evt, 'Post', 'self' )}
  bind_click_to_submit_with_action form, :submit, action

  disable_submit_for form
end

def process_message_for view_name, model_name, attributes
  element = Element.find( 'form.new-post' )
  view_model = Utils.view_model_for( model_name )

  view_model.update_element_for_new element, attributes
end

Document.ready? do
  init_form
end