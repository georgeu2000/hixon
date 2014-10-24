class AllTodoView < ViewModel
  class << self
    def update_element_field element, key, value
      element.children( "[ name='#{ key }' ]" ).attr( 'value', value )
    end

    def bind_for_new element
      disable_submit_for element

      bind_enter_to_input element, :text
      bind_click_to_input element, :done
      bind_click_to_link  element, :delete
    end

    def model
      Todo
    end

    def data_view
      'all-todo'
    end

    def element_template
      'todo'
    end
  end
end