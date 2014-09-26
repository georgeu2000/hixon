class Item
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic
  field :signature, type:Integer
  field :cid,       type:String
  

  class << self
    def action_create signature, params
      Item.create params.merge( signature:signature )
      send_message_for signature, params
    end

    def action_read signature, params
      puts "#{ self } #{ __method__ } #{ signature } #{ params }"
      MessageToBrowser.send_items_to signature
    end

    def message_for signature, data
      puts "#{ self }.#{ __method__ } creating for #{ signature } with #{ data }"
      
      parsed = JSON.parse( data, symbolize_names:true )
      
      action = 'action_' + parsed.delete( :action )
      
      send action.to_sym, signature, parsed
    end

    def send_message_for signature, params
      puts "#{ self } #{ __method__ } #{ signature } #{ params }"

      message = { item:{ name:params[ :name ]}}.to_json
      MessageToBrowser.create( message:message, 
                               signature:signature    )
    end
  end
end