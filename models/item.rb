class Item
  include Mongoid::Document
  field :signature, type:Integer
  field :name,      type:String
  

  class << self
    def message_for signature
      puts "#{ self }.#{ __method__ } creating for #{ signature }"
      Item.create( signature:signature )

      send_message_for signature
    end

    def send_message_for signature
      puts "#{ self } creating queue item."

      MessageToBrowser.create( message:'item created', 
                               signature:signature   )
    end
  end
end