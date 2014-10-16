class ViewModel
  class << self
    def init
      #NOP
    end

    def model_name
      self.to_s.gsub( /View$/, '' )
    end
  end
end