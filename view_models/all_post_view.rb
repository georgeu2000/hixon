class AllPostView < PostView
  class << self
    def init
      send_data( action:'read',  model:model_name, 
                 view:data_view, filter:''       )
    end

    def bind_for_new new_element
      new_element.on( :click ) do |evt|
        model = new_element.data( 'model' )
        view  = 'single'
        cid = new_element.attr( 'data-cid' )

        LocalStorage[ :single_post_cid ] = cid

        get_page 'single_post'
      end
    end

    def data_view
      'all-post'
    end

    def element_template
      'all-post'
    end
  end
end