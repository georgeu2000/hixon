class ViewModel
  class << self
    def render_new #rename to html_for_new
      model = 'Item'
      
      attributes = {
        cid: Cid.generate,
        name:'New Name'
      }

      html_for model, attributes
    end

    def html_for model, attributes #rename to html_for_update
      "<div class='#{ model.downcase }' data-model='#{ model }' 
            data-cid='#{ attributes[ :cid ]}'>" +
        inputs_to_edit( attributes ) +
        "<button name='submit'>submit</button>
      </div>"
    end

    def html_for_read model, attributes
      "<div class='#{ model.downcase }' data-model='#{ model }' 
            data-cid='#{ attributes[ :cid ]}'>" +
      inputs_to_view( attributes ) +
      "</div>"
    end

    def html_for_delete model, attributes
      "<div class='#{ model.downcase }' data-model='#{ model }' 
            data-cid='#{ attributes[ :cid ]}'>" +
        inputs_to_view( attributes ) +
        "<button name='delete'>delete</button>
      </div>"
    end

    def inputs_to_edit attributes
      @@INPUTS.map do |input|
        name  = input[ :name ]
        type  = input[ :type ]
        value = attributes[ name ]

        "#{ name }:<input type='#{ type }' name='#{ name }' 
                          data-name='#{ name }' value='#{ value }'><br />"
      end.join
    end
      
    def inputs_to_view attributes
      @@INPUTS.map do |input|
        name  = input[ :name ]
        value = attributes[ name ]
        "#{ name }:<span data-name='#{ name }'>#{ value }</span><br />"
      end.join
    end

    def model_name
      self.to_s.gsub( /View$/, '' )
    end
  end
end