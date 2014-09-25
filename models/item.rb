class Item
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic
  field :signature, type:Integer
  
  

  class << self
    def message_for signature, data
      puts "#{ self }.#{ __method__ } creating for #{ signature } with #{ data }"
      parsed = JSON.parse( data, symbolize_names:true )
      Item.create parsed.merge( signature:signature )

      send_message_for signature
    end

    def send_message_for signature
      puts "#{ self } creating queue item."

      MessageToBrowser.create( message:'item created', 
                               signature:signature   )
    end
  end
end