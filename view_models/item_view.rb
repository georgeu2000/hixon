class ItemView
  class << self
    def render_new
      model = 'item'
      
      attributes = {
        cid: Cid.generate,
        name:'New Name'
      }

      html_for model, attributes
    end

    def html_for_read model, attributes
      "<div class='#{ model.downcase }' data-model='#{ model.downcase }' 
            data-cid='#{ attributes[ :cid ]}'>
        Name:<span data-name='name'>#{ attributes[ :name ]}</span><br />
      </div>"
    end

    def html_for model, attributes
      "<div class='#{ model.downcase }' data-model='#{ model.downcase }' 
            data-cid='#{ attributes[ :cid ]}'>
        Name:<input type='text' name='name' value='#{ attributes[ :name ]}'><br />
        <button name='submit'>submit</button>
      </div>"
    end

    def html_for_delete model, attributes
      "<div class='#{ model.downcase }' data-model='#{ model.downcase }' 
            data-cid='#{ attributes[ :cid ]}'>
        Name:<span name='name'>#{ attributes[ :name ]}</span><br />
        <button name='delete'>delete</button>
      </div>"
    end
  end
end

