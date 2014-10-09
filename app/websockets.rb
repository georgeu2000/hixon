require 'em-websocket'
require './app/init'
require './models/exception'
require './models/logger'


EventMachine.run do
  Logger.write 'Starting WebSocket Server'

  @clients = []

  EM::WebSocket.start(:host => '127.0.0.1', :port => '3001') do |ws|
    ws.onopen do
      ws.send ({ status:'open' }.to_json )
      @clients << ws
    end

    ws.onclose do
      ws.send( { status:'closed' }.to_json )
      @clients.delete ws
    end

    ws.onmessage do |message|
      Logger.write "Message received: #{ message }"
      Controller.process_message_for ws.signature, message
    end
  end

  EM.add_periodic_timer( 0.1 ){ check_queue }

  def check_queue
    message = MessageToBrowser.first
    return if message.nil?

    if message.object.nil?
      message.delete
      Logger.write "#{ self }##{ __method__ } object is nil."
      return
    end

    send_message message.prepare_data
    message.delete
  end


  def send_message data
    Logger.write "EM.#{ __method__ }: Total of #{ @clients.count } clients connected."
    signature = data.delete( :signature )
    ws = @clients.select{| ws | ws.signature == signature }.first
    
    if ws.nil?
      Logger.write "No socket with signature #{ signature }"
      return
    end

    Logger.write "EM.#{ __method__ } to #{ ws.signature }"
    ws.send data.to_json
  end
end
