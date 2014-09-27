class Item
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic
  field :signature, type:Integer
  field :cid,       type:String
  has_one :message_to_browser
  

  class << self
    def action_create signature, params
      puts "#{ self }.#{ __method__ } signature:#{ signature } #{ params }"
      item = Item.create params.merge( signature:signature )
      MessageToBrowser.create( item:item )
    end

    def action_read signature, params
      puts "#{ self }.#{ __method__ } signature:#{ signature } #{ params }"
      MessageToBrowser.send_items_to signature
    end

    def action_update signature, params
      puts "#{ self }.#{ __method__ } signature:#{ signature } #{ params }"
      item = Item.where( cid:params[ :cid ]).first
      item.name = params[ :name ]
      item.save
    end

    def action_delete signature, params
      puts "#{ self }.#{ __method__ } signature:#{ signature } #{ params }"
      item = Item.where( cid:params[ :cid ]).first
      item.delete if item
    end

    def message_for signature, data
      puts "#{ self }.#{ __method__ } creating for #{ signature } with #{ data }"
      
      parsed = JSON.parse( data, symbolize_names:true )
      action = 'action_' + parsed.delete( :action )
      
      send action.to_sym, signature, parsed
    end
  end
end