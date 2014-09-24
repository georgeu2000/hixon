require 'em-websocket'
require './app/init'


@em = EventMachine.run do
  puts 'Starting WebSocket Server'

  @clients = []

  EM::WebSocket.start(:host => '127.0.0.1', :port => '3001') do |ws|
    ws.onopen do |handshake|
      puts 'Connection open'
      ws.send "Connected to #{handshake.path}."
      @clients << ws
    end

    ws.onclose do
      ws.send "Closed."
      puts 'Connection closed.'
      @clients.delete ws
    end

    ws.onmessage do |msg|
      puts "Message received: #{ msg }"
      Store.message
    end
  end

  EM.add_periodic_timer( 1 ){ check_queue }

  def check_queue
    item = QueueItem.first
    return if item.nil?

    send_message item.message
    item.delete
  end

  def send_message message
    puts "EM.#{ __method__ } sending to #{ @clients.count } clients."
    @clients.each do |ws|
      puts 'EM send_message.'
      ws.send message
    end
  end
end


