class PostView < ViewModel
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