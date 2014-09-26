def read_items
  puts "#{ __method__ } starting..."
  send_data( action:'read' )
end



Document.ready? do
  read_items
end