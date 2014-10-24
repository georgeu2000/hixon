class NewTodoView < ViewModel
  class << self
    def init
      set_content get_template( 'new_todo.html' )
      
      action = lambda{ |evt| create_object_for( evt, 'Todo', 'all-todo' )}
      
      bind_form_to action
    end

    def bind_form_to action
      form = element.find( 'form' )

      bind_enter_to_input_with_action form, :text, action
      bind_enter_to_clear_input form, :text

      disable_submit_for form
    end

    def model
      Todo
    end

    def model_name
      'Todo'
    end

    def data_view
      'new-todo'
    end
  end
end
