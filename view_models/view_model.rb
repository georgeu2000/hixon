class ViewModel
  class << self
    def init
      #NOP
    end

    def set_content html
      element.html html
    end

    def element
      Element.find( "[ data-view='#{ data_view }' ]" )
    end

    def model_name
      #TODO - Depricate?
      self.to_s.gsub( /View$/, '' )
    end
  end
end