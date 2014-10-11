class PostView < ViewModel
  class << self
    def update_element element, attributes
      attributes.delete :signature
      element.attr( 'data-cid', attributes.delete( :cid ))
      
      attributes.each do |key, value|
        element.children( "[ name='#{ key }' ]" ).text value
      end

      element
    end
    
    def new_element_for template, attributes
      html = get_template( "#{ template }.html" )
      new_element = Element.parse( html )
      
      update_element new_element, attributes
    end

    def update_for_message view_name, model_name, attributes
      view_element = Element.find( "[ data-view='#{ view_name.gsub( '_', '-' )}' ]" )
      finder = ".#{ model_name.downcase }[ data-cid='#{ attributes[ :cid ]}' ]"

      if attributes[ :removed ]
        element = Element.find( finder )
        element.remove if element

        return
      end

      if has_child?( view_element, finder )
        this_element = Element.find( ".#{ model.downcase }[ data-cid='#{ attributes[ :cid ]}' ]" )
        view_model = Utils.view_model_for( model_name )

        view_model.update_element_for_read element, attributes
        return
      end

      create_element_for view_element, model_name, attributes
    end

    def create_element_for view_element, model_name, attributes
      new_element = new_element_for( data_view, attributes )
      view_element.append new_element
      bind_for new_element
    end

    def bind_for new_element
      #NOP
    end

    def bind_form_to action
      form = element.find( 'form' )
      bind_click_to_submit_with_action form, :submit, action

      disable_submit_for form
    end

    def set_content html
      element.html html
    end

    def element
      Element.find( "[ data-view='#{ data_view }' ]" )
    end

    def model
      Post
    end

    def model_name
      'Post'
    end
  end
end