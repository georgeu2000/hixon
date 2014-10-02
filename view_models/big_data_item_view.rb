class BigDataItemView < ViewModel
  class << self
    def fields
      [ :name, :birthday, :favorite_car, :sushi, :drink ]
    end

    def html_for_new
      get_template 'big_data_item_form.html'
    end

    def alternate_html_for_read model
      get_template 'big_data_item_read.html'
    end

    def coke_only
      send_data( action:'read',   model:'BigDataItem' , 
                 view:__method__, filter:'drink:Coke' )
    end
  end
end
