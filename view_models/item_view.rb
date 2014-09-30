class ItemView < ViewModel
  @@INPUTS = [{ name:'name', type:'text' }]

  class << self
    def alternate_html_for_new
      get_template 'item_view.html'
    end
  end
end
