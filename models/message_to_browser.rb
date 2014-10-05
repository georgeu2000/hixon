class MessageToBrowser
  include Mongoid::Document
  field :view,      type:String
  field :model,     type:String
  field :target_id, type:String
  

  class << self
    def send_objects_to params
      klass = Utils.class_for( params[ :model ])
      filter_hash = filter_hash_for( params[ :filter ])

      klass.where( filter_hash ).each do |target|
        puts "#{ self }.#{ __method__ } #{ params }"
        
        MessageToBrowser.create( model:params[ :model ], view:params[ :view ], target_id:target.id )
      end
    end

    def filter_hash_for filter
      return {} unless filter

      parts = filter.split( ':' )
      { parts[ 0 ] => parts[ 1 ]}
    end
  end

  def prepare_data
    attributes = object.attributes
    attributes.delete( '_id'   )
    attributes.delete( '_type' )
    attributes.merge( cid:object.cid )

    { signature:object.signature, model:object.class.to_s,
      view:view, attributes:attributes }
  end

  def object
    klass = Utils.class_for( model )
    klass.where( _id:target_id ).first
  end
end