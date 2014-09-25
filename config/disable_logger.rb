module Rack
  class CommonLogger
    def call env 
      @app.call env
    end
  end
end