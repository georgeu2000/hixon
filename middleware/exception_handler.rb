class ExceptionHandler
  def initialize(app)
    @app = app
  end
 
  def call(env)
    begin
      @app.call env
    rescue => ex
      env['rack.errors'].puts ex
      env['rack.errors'].puts ex.backtrace.first
      env['rack.errors'].flush
 
      [500, {'Content-Type' => 'application/text'}, [ 'Error' ]]
    end
  end
end