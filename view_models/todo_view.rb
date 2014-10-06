class TodoView < ViewModel
  class << self
    def fields
      [ :text, :done ]
    end

    def new_todo
      get_template 'new_todo.html'
    end

    def new_element_for attributes
      html = get_template( 'todo_read.html' )
      new_todo = Element.parse( html )
      
      update_element new_todo, attributes
    end

    def update_element element, attributes
      element.attr( 'data-cid', attributes[ :cid ])
      
      if attributes[ :done ] == 'true'
        element.children( "input[ name='done' ]" ).attr( 'checked', true )
      end 
      
      element.children( "input[ name='text' ]" ).attr( 'value', attributes[ :text ])

      element
    end

    def all
      send_data( action:'read',   model:model_name, 
                 view:__method__, filter:''    )
    end
  end
end
