require 'em-websocket'
require './app/init'


EventMachine.run do
  puts 'Starting WebSocket Server'

  EM::WebSocket.start(:host => '127.0.0.1', :port => '3001') do |ws|
    ws.onopen do |handshake|
      ws.send "Connected to #{handshake.path}."
    end

    ws.onclose do
      ws.send "Closed."
    end

    ws.onmessage do |msg|
      puts "Received Message: #{msg}"
      Store.message
    end
  end
end

# trap( 'SIGINT' ){ puts 'Stopping WebSocket Server'; exit }
