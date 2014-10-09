class PostView < ViewModel
  class << self
    def new_post
      get_template 'new_post.html'
    end

    def update_element element, attributes
      attributes.delete :signature
      element.attr( 'data-cid', attributes.delete( :cid ))
      
      attributes.each do |key, value|
        element.children( "[ name='#{ key }' ]" ).text value
      end

      element
    end

    
    def new_element_for attributes
      html = get_template( 'all_posts.html' )
      new_element = Element.parse( html )
      
      update_element new_element, attributes
    end

    
    def new_element_for_single_view attributes
      html = get_template( 'single_post.html' )
      new_element = Element.parse( html )
      
      update_element new_element, attributes
    end

    def single_post
      cid = LocalStorage[ :single_post_cid ]

      send_data( action:'read',   model:model_name      , 
                 view:__method__, filter:"cid:#{ cid }" )
    end

    def all_posts
      send_data( action:'read',   model:model_name, 
                 view:__method__, filter:''    )
    end
  end
end