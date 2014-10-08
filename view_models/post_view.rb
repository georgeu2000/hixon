class PostView < ViewModel
  class << self
    def new_post
      get_template 'new_post.html'
    end

    def update_element_for_new element, attributes
      element.attr( 'data-cid', attributes[ :cid ])
      
      element.children( "[ name='title' ]" ).text attributes[ :title ]
      element.children( "[ name='body'  ]" ).text attributes[ :body  ]

      element
    end

    def update_element_for_view_all element, attributes
      element.attr( 'data-cid', attributes[ :cid ])
      
      element.find( "[ name='title' ]" ).text attributes[ :title ]
      
      element
    end

    def new_element_for attributes
      html = get_template( 'all_posts.html' )
      new_element = Element.parse( html )
      
      update_element_for_view_all new_element, attributes
    end

    def update_element_for_single_view element, attributes
      element.attr( 'data-cid', attributes[ :cid ])
      
      element.find( "[ name='title' ]" ).text attributes[ :title ]
      element.find( "[ name='body'  ]" ).text attributes[ :body  ]
      
      element
    end

    def new_element_for_single_view attributes
      html = get_template( 'single_post.html' )
      new_element = Element.parse( html )
      
      update_element_for_single_view new_element, attributes
    end

    def single
      cid = LocalStorage[ :single_post_cid ]

      send_data( action:'read',   model:model_name      , 
                 view:__method__, filter:"cid:#{ cid }" )
    end

    def all
      send_data( action:'read',   model:model_name, 
                 view:__method__, filter:''    )
    end
  end
end