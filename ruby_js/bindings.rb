def bind_enter_to_input element, name
  element.children( "input[ name='#{ name }' ]" ).on( :keypress ) do |evt|
    if evt.key_code == ENTER_KEY
      save_for evt
    end
  end
end

def bind_click_to_input element, name
  element.children( "input[ name='#{ name }' ]" ).on( :click ) do |evt|
    save_for evt
  end
end

def bind_click_to_link element, name
  element.children( "a[ name='#{ name }' ]" ).on( :click ) do |evt|
    delete_for evt
  end
end

def bind_enter_to_input_with_action form, name, action
  form.find( "input[ name='#{ name }' ]" ).on( :keypress ) do |evt|
    action.call( evt ) if evt.key_code == ENTER_KEY
  end
end

def bind_enter_to_clear_input form, name
  action = lambda{ |evt| evt.target.value = '' }
  bind_enter_to_input_with_action form, name, action
end