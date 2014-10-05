
def init_form
  Element.find( "div#new-todo" ).html TodoView.new_todo
  
  bind_new_todo_form "form.new-todo input[ name='text' ]"
  disable_submit_for 'form.new-todo'
end

def bind_new_todo_form finder
  Element.find( finder ).on( :keypress ) do |evt|
    if evt.key_code == ENTER_KEY
      create_for evt, 'Todo', 'all'
      evt.target.value = ''
    end
  end
end

def create_for evt, model, view
  div = Element.find( evt.target ).parent
  data = data_for( div )

  data.merge!( model:model, cid:Cid.generate, view:view )
  
  create_item_for data
end

def save_for evt, model, view
  div = Element.find( evt.target ).parent
  data = data_for( div )

  cid = div.attr( 'data-cid' )

  data.merge!( model:model, cid:cid, view:view )
  
  update_item_for data
end

def delete_for evt, view
  todo = Element.find( evt.target ).parent
  model = todo.data( 'model' )
  view  = todo.parent.data( 'view' )
  cid   = todo.data( 'cid' )

  send_data( action:'delete', model:model, view:view, cid:cid )
end

class Socket
  def on_message json_data
    puts "Browser received data: #{ json_data }"
    
    parsed = JSON.parse( json_data ,symbolize_keys:true )
    model  = parsed[ :model ]
    view   = parsed[ :view  ]
    attributes = parsed[ :attributes ]
    return unless attributes
    
    create_or_update_for view, attributes
  end

  def create_or_update_for view, attributes
    view_element = Element.find( "[ data-view='#{ view }' ]" )
    
    finder_for_todo = ".todo[ data-cid='#{ attributes[ :cid ]}' ]"

    if has_child?( view_element, finder_for_todo ) && attributes[ :removed ]
      Element.find( finder_for_todo ).remove
    end
    
    crupdate_element_for view, attributes
  end

  def crupdate_element_for view, attributes
    return if attributes[ :removed ]

    view_element = Element.find( "[ data-view='#{ view }' ]" )
    finder_for_todo = ".todo[ data-cid='#{ attributes[ :cid ]}' ]"

    if has_child?( view_element, finder_for_todo )
      set_for attributes
      return
    end

    read_todo = TodoView.todo_read_for( attributes )
    view_element.append read_todo
    bind_todo_for read_todo 
  end

  def set_for attributes
    this_todo = Element.find( ".todos[ data-cid='#{ attributes[ :cid ]}' ]" )
    
    if attributes[ :done ] == 'true'
      this_todo.children( "input[ name='done' ]" ).attr( 'checked', true )
    end 
    this_todo.children( "input[ name='text' ]" ).attr( 'value', attributes[ :text ])
  end
end

def bind_todo_for read_todo
  disable_submit_for read_todo

  read_todo.children( "input[ name='text' ]" ).on( :keypress ) do |evt|
    if evt.key_code == ENTER_KEY
      save_for evt, 'Todo', 'all'
    end
  end

  read_todo.children( "input[ name='done' ]" ).on( :click ) do |evt|
    save_for evt, 'Todo', 'all'
  end

  read_todo.children( "a[ name='delete' ]" ).on( :click ) do |evt|
    delete_for evt, 'all'
  end
end


Document.ready? do
  init_form
  init_views_for TodoView
end

ENTER_KEY = 13