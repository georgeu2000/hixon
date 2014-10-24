class Utils
  class << self
    def class_for model
      Object.const_get( model )     
    end

    def view_for model
      "#{ model }View"
    end

    def view_model_for model
      class_for view_for( model )
    end

    def view_model_for_view_name view_name
      raise "#{ self }##{ __method__ } view_name is nil" if view_name.nil?

      class_for( camelcase_for( view_name + '-view' ))
    end

    def camelcase_for str
      str.split( /-|_/ ).collect( &:capitalize ).join
    end
  end
end