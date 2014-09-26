var socket, host;
host = "ws://127.0.0.1:3001";

function addMessage(msg) {
  // $("#chat-log").append("" + msg + "<br />");
}

function send() {
  try {
    console.log('Browser sending...');
    socket.send('{"action":"create", "name":"name"}');
    addMessage("Sent")
  } catch(exception) {
    addMessage("Failed To Send")
  }
}


function bindControls(){
  $('#create_item').click(function(){
    send();
  })

  $('#message').keypress(function(event) {
    if (event.keyCode == '13') { send(); }
  });

  $("#disconnect").click(function() {
    socket.close()
  });
};

function connect() {
  try {
    socket = new WebSocket(host);

    addMessage("Socket State: " + socket.readyState);

    socket.onopen = function() {
      addMessage("Socket Status: " + socket.readyState + " (open)");
    }

    socket.onclose = function() {
      addMessage("Socket Status: " + socket.readyState + " (closed)");
    }

    socket.onmessage = function( message ){
      onMessage( message );
    }
  } catch(exception) {
    addMessage("Error: " + exception);
  }
}

function onMessage( message ){
  console.log( 'Received message: ' + message.data );
  
  var parsed = JSON.parse( message.data ).item;
  
  if ( parsed ){ 
    html = "<div class='item'>" + parsed[ 'name' ] + "</item>";
    $( "#items" ).append( html );
  }
}

$(function() {
  bindControls();
  connect();
});
