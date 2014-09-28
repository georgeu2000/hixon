class Controller
  class << self
    def action_create signature, params
      puts "#{ self }.#{ __method__ } signature:#{ signature } #{ params }"
      klass = Module.const_get( params[ :model ].capitalize )
      object = klass.create params.merge( signature:signature )

      MessageToBrowser.create( model:params[ :model ], target_id:object.id )
    end

    def action_read signature, params
      puts "#{ self }.#{ __method__ } signature:#{ signature } #{ params }"
      MessageToBrowser.send_objects_to signature, params[ :model ]
    end

    def action_update signature, params
      puts "#{ self }.#{ __method__ } signature:#{ signature } #{ params }"

      klass = Module.const_get( params[ :model ].capitalize )      
      object = klass.where( cid:params[ :cid ]).first
      object.name = params[ :name ]
      object.save
    end

    def action_delete signature, params
      puts "#{ self }.#{ __method__ } signature:#{ signature } #{ params }"

      klass = Module.const_get( params[ :model ].capitalize )
      object = klass.where( cid:params[ :cid ]).first
      object.delete if object
    end

    def message_for signature, data
      puts "#{ self }.#{ __method__ } creating for #{ signature } with #{ data }"
      
      parsed = JSON.parse( data, symbolize_names:true )
      action = 'action_' + parsed.delete( :action )
      
      send action.to_sym, signature, parsed
    end
  end
end