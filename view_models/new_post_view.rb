class NewPostView < PostView
  class << self
    def init
      set_content get_template( 'new_post.html' )

      action = lambda{ |evt| create_object_for( evt, 'Post', 'new-post' )}
      bind_form_to action
    end

    def update_for_message view_name, model_name, attributes
      init
    end

    def data_view
      'new-post'
    end
  end
end
