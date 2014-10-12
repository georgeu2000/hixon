class NewItemView < ViewModel
  class << self
    def init
      set_content get_template( 'item_view.html' )

      bind

      # action = lambda{ |evt| create_object_for( evt, 'Post', 'new-post' )}
      # bind_form_to action
    end

    def bind
      # Element.find( "div.item button[ name='submit' ]" ).on( :click ) do
      #   name = Element.find( "div.item input[ name='name' ]" ).value
      #   cid  = Cid.generate
        
      #   Element.find( 'div.item' ).attr( 'data-cid', cid )
      #   create_item_for( model:'Item', cid:cid, name:name )
      # end

      action = lambda do
        name = Element.find( "div.item input[ name='name' ]" ).value
        cid  = Cid.generate
        
        Element.find( 'div.item' ).attr( 'data-cid', cid )
        create_item_for( model:'Item', cid:cid, name:name )
      end

      bind_form_to action
    end

    def bind_form_to action
      form = element.find( 'div.item' )
      bind_enter_to_input_with_action form, :name, action

      disable_submit_for form
    end


    def create_item_for params
      send_data( action:'create', model:params[ :model ], name:params[ :name ], cid:params[ :cid ])
    end

    def model
      'Item'
    end

    def data_view
      'new-item'
    end
  end
end