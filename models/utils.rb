class Utils
  class << self
    def class_for model
      # camelcase = string.split( '_' ).map( &:capitalize ).join
      Object.const_get( model )     
    end
  end
end