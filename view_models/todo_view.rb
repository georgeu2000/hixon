class TodoView < ViewModel
  class << self
    def fields
      [ :text, :done ]
    end

    def new_todo
      get_template 'new_todo.html'
    end

    def todo_read_for attributes
      html = get_template( 'todo_read.html' )
      read_todo = Element.parse( html )
      
      read_todo.attr( 'data-cid', attributes[ :cid ])
      if attributes[ :done ] == 'true'
        read_todo.children( "input[ name='done' ]" ).attr( 'checked', true )
      end 
      read_todo.children( "input[ name='text' ]" ).attr( 'value', attributes[ :text ])

      read_todo
    end

    def all
      send_data( action:'read',   model:'Todo' , 
                 view:__method__, filter:''    )
    end
  end
end
