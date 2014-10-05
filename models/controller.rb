class Controller
  class << self
    def action_create signature, params
      puts "#{ self }.#{ __method__ } signature:#{ signature } #{ params }"
      
      klass = Utils.class_for( params.delete( :model ))
      object = klass.create_for( params.merge( signature:signature ))
    end

    def action_read signature, params
      puts "#{ self }.#{ __method__ } signature:#{ signature } #{ params }"
      
      MessageToBrowser.send_objects_to params.merge( signature:signature )
    end

    def action_update signature, params
      puts "#{ self }.#{ __method__ } signature:#{ signature } #{ params }"

      klass = Utils.class_for( params.delete( :model ))
      object = klass.where( cid:params[ :cid ]).first
      object.update_for params
      object.save
    end

    def action_delete signature, params
      puts "#{ self }.#{ __method__ } signature:#{ signature } #{ params }"

      klass = Utils.class_for( params.delete( :model ))
      object = klass.where( cid:params[ :cid ]).first
      object.delete_for( params[ :view ]) if object
    end

    def process_message_for signature, data
      puts "#{ self }.#{ __method__ } for #{ signature } with #{ data }"
      
      parsed = JSON.parse( data, symbolize_names:true )
      action = 'action_' + parsed.delete( :action )
      
      send action.to_sym, signature, parsed
    end
  end
end