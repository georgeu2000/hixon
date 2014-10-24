class PostView < ViewModel
  #TODO change to SinglePostView ?
  class << self
    def update_element_field element, key, value
      element.children( "[ name='#{ key }' ]" ).text value
    end

    def model
      Post
    end

    def model_name
      'Post'
    end
  end
end