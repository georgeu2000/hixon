class NewPostView < PostView
  class << self
    def init
      set_content get_template( 'new_post.html' )

      action = lambda{ |evt| create_object_for( evt, 'Post', 'new-post' )}
      bind_form_to action
    end

    def bind_form_to action
      form = element.find( 'form' )
      bind_click_to_submit_with_action form, :submit, action

      disable_submit_for form
    end

    def update_for_message view_name, model_name, attributes
      init
    end

    def data_view
      'new-post'
    end

    def element_template
      'single_post'
    end
  end
end
