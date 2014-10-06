class Utils
  class << self
    def class_for model
      # camelcase = string.split( '_' ).map( &:capitalize ).join
      Object.const_get( model )     
    end

    def view_for model
      "#{ model }View"
    end

    def view_model_for model
      class_for view_for( model )
    end
  end
end