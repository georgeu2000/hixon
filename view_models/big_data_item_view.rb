class BigDataItemView < ViewModel
  class << self
    def fields
      [ :name, :birthday, :birthtime, :favorite_car, :sushi, :drink ]
    end

    def alternate_html_for_new
      get_template 'big_data_item_view.html'
    end
  end
end
