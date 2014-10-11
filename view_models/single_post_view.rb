class SinglePostView < PostView
  class << self
    def init
      cid = LocalStorage[ :single_post_cid ]

      send_data( action:'read',  model:model_name      , 
                 view:data_view, filter:"cid:#{ cid }" )
    end

    def data_view
      'single-post'
    end
  end
end