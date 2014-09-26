require 'em-websocket'
require './app/init'


EventMachine.run do
  puts 'Starting WebSocket Server'

  @clients = []

  EM::WebSocket.start(:host => '127.0.0.1', :port => '3001') do |ws|
    ws.onopen do
      puts 'Connection opened.'
      ws.send ({ status:'open' }.to_json )
      @clients << ws
    end

    ws.onclose do
      ws.send( { status:'closed' }.to_json )
      puts 'Connection closed.'
      @clients.delete ws
    end

    ws.onmessage do |message|
      puts "Message received: #{ message }"
      Item.message_for ws.signature, message
    end
  end

  EM.add_periodic_timer( 0.1 ){ check_queue }

  def check_queue
    item = MessageToBrowser.first
    return if item.nil?

    send_message item.message, item.signature
    item.delete
  end

  def send_message message, signature
    puts "EM.#{ __method__ }: Total of #{ @clients.count } clients connected."
    ws = @clients.select{| ws | ws.signature == signature }.first
    if ws.nil?
      puts "No socket with signature #{ signature }"
      return
    end

    puts "EM.#{ __method__ } to #{ ws.signature }"
    ws.send message
  end
end
